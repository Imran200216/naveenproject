import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/screens/AdminScreens/AdminBottomNavBar.dart';
import 'package:empprojectdemo/screens/EmployeeScreens/EmployeeBottomNavBar.dart';
import 'package:empprojectdemo/screens/email_auth_login_screen.dart';
import 'package:empprojectdemo/screens/email_user_photo_screen.dart';
import 'package:empprojectdemo/screens/user_type_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailAuthenticationProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();
  final TextEditingController registerConfirmPasswordController =
      TextEditingController();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController forgetPasswordEmailController =
      TextEditingController();

  User? get emailUser => _auth.currentUser;

  Future<void> _saveLoginState(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<void> registerWithEmailPassword(BuildContext context) async {
    final String name = nameController.text.trim();
    final String email = registerEmailController.text.trim();
    final String password = registerPasswordController.text.trim();
    final String confirmPassword =
        registerConfirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showErrorToast(context, "Please fill out all fields");
      return;
    }

    if (password != confirmPassword) {
      _showErrorToast(context, "Passwords do not match");
      return;
    }

    _setLoadingState(true);
    _clearErrorMessage();

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? emailUser = userCredential.user;
      if (emailUser != null) {
        await emailUser.updateDisplayName(name);
        await _saveLoginState(true);

        await FirebaseFirestore.instance
            .collection('userByEmailAuth')
            .doc(emailUser.uid)
            .set({
          'name': name,
          'email': email,
          'uid': emailUser.uid,
        });

        _clearControllers();
        _showSuccessToast(context, "Registration Successful!");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => EmailUserPhotoScreen(uid: emailUser.uid)),
        );
      }
    } on FirebaseAuthException catch (e) {
      _showErrorToast(context, e.message ?? "An error occurred");
    } finally {
      _setLoadingState(false);
    }
  }

  Future<void> loginWithEmailPassword(BuildContext context) async {
    final String email = loginEmailController.text.trim();
    final String password = loginPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorToast(context, "Please fill out all fields");
      return;
    }

    _setLoadingState(true);
    _clearErrorMessage();

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? emailUser = userCredential.user;
      if (emailUser != null) {
        await _saveLoginState(true);

        _clearControllers();
        _showSuccessToast(context, "Login Successful!");

        final prefs = await SharedPreferences.getInstance();
        final String? personType = prefs.getString('personType');

        if (personType == null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const UserTypeScreen()));
        } else {
          if (personType == 'admin') {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => AdminBottomNavBar()));
          } else if (personType == 'employee') {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => EmployeeBottomNavBar()));
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      _showErrorToast(context, e.message ?? "An error occurred");
    } finally {
      _setLoadingState(false);
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      await _saveLoginState(false);
      _showSuccessToast(context, "Sign Out Successful!");

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const EmailAuthLoginScreen()));
    } catch (e) {
      _showErrorToast(context, "Sign Out Failed!");
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(
              email: forgetPasswordEmailController.text.trim())
          .then((value) {
        forgetPasswordEmailController.clear();
        _showSuccessToast(
            context, "Password reset link sent! Check your email");
      });
    } catch (e) {
      _showErrorToast(context, "Failed to send reset link. Try again later.");
    }
  }

  void _showErrorToast(BuildContext context, String message) {
    _errorMessage = message;
    DelightToastBar(
      snackbarDuration: const Duration(seconds: 5),
      autoDismiss: true,
      position: DelightSnackbarPosition.top,
      builder: (context) => ToastCard(
        color: AppColors.failureToastColor,
        leading: Icon(Icons.error, color: AppColors.whiteColor, size: 28),
        title: Text(
          _errorMessage,
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.whiteColor),
        ),
      ),
    ).show(context);
    notifyListeners();
  }

  void _showSuccessToast(BuildContext context, String message) {
    DelightToastBar(
      snackbarDuration: const Duration(seconds: 5),
      autoDismiss: true,
      position: DelightSnackbarPosition.top,
      builder: (context) => ToastCard(
        color: AppColors.successToastColor,
        leading: SvgPicture.asset(
          "assets/images/svg/auth-success-icon.svg",
          height: 28,
          width: 28,
          fit: BoxFit.cover,
          color: AppColors.whiteColor,
        ),
        title: Text(
          message,
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.whiteColor),
        ),
      ),
    ).show(context);
    notifyListeners();
  }

  void _setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _clearErrorMessage() {
    _errorMessage = '';
    notifyListeners();
  }

  void _clearControllers() {
    nameController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    registerConfirmPasswordController.clear();
    loginEmailController.clear();
    loginPasswordController.clear();
    forgetPasswordEmailController.clear();
  }
}
