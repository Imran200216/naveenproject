import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/screens/EmployeeScreens/email_auth_login_screen.dart';
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

  bool get isLoading => _isLoading;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();
  final TextEditingController registerConfirmPasswordController =
      TextEditingController();

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  // Getter for current user
  User? get emailUser => _auth.currentUser;

  Future<void> _saveLoginState(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  // Function to get saved login state
  Future<bool> _getLoginState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  // Function to register with email and password
  Future<void> registerWithEmailPassword(BuildContext context) async {
    final String name = nameController.text.trim();
    final String email = registerEmailController.text.trim();
    final String password = registerPasswordController.text.trim();
    final String confirmPassword =
        registerConfirmPasswordController.text.trim();

    // Check if any field is empty
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _errorMessage = "Please fill out all fields";
      DelightToastBar(
        snackbarDuration: const Duration(seconds: 5),
        autoDismiss: true,
        position: DelightSnackbarPosition.top,
        builder: (context) => ToastCard(
          color: AppColors.failureToastColor,
          leading: Icon(
            Icons.warning,
            color: AppColors.whiteColor,
            size: 28,
          ),
          title: Text(
            _errorMessage,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ).show(context);
      notifyListeners();
      return;
    }

    // Check if passwords match
    if (password != confirmPassword) {
      _errorMessage = "Passwords do not match";
      DelightToastBar(
        snackbarDuration: const Duration(seconds: 5),
        autoDismiss: true,
        position: DelightSnackbarPosition.top,
        builder: (context) => ToastCard(
          color: AppColors.failureToastColor,
          leading: Icon(
            Icons.error,
            color: AppColors.whiteColor,
            size: 28,
          ),
          title: Text(
            "Password doesn't match!",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ).show(context);
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = ''; // Clear previous errors
    notifyListeners();

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? emailUser = userCredential.user;
      if (emailUser != null) {
        await emailUser.updateDisplayName(name);

        // Save login state
        await _saveLoginState(true);

        // Store user details in Fire store
        await FirebaseFirestore.instance
            .collection('userByEmailAuth')
            .doc(emailUser.uid)
            .set({
          'name': name,
          'email': email,
          'uid': emailUser.uid,
        });

        nameController.clear();
        registerEmailController.clear();
        registerPasswordController.clear();
        registerConfirmPasswordController.clear();

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
              "Registration Successful!",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ).show(context);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => EmailUserPhotoScreen(
                      uid: emailUser.uid,
                    )));
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? "An error occurred";

      DelightToastBar(
        position: DelightSnackbarPosition.top,
        autoDismiss: true,
        snackbarDuration: const Duration(seconds: 5),
        builder: (context) => ToastCard(
          color: AppColors.failureToastColor,
          leading: Icon(
            Icons.error,
            color: AppColors.whiteColor,
            size: 20,
          ),
          title: Text(
            _errorMessage,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ).show(context);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Function to log in with email and password
  Future<void> loginWithEmailPassword(BuildContext context) async {
    final String email = loginEmailController.text.trim();
    final String password = loginPasswordController.text.trim();

    // Check if any field is empty
    if (email.isEmpty || password.isEmpty) {
      _errorMessage = "Please fill out all fields";
      DelightToastBar(
        snackbarDuration: const Duration(seconds: 5),
        autoDismiss: true,
        position: DelightSnackbarPosition.top,
        builder: (context) => ToastCard(
          color: AppColors.failureToastColor,
          leading: Icon(
            Icons.warning,
            color: AppColors.whiteColor,
            size: 28,
          ),
          title: Text(
            _errorMessage,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ).show(context);
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = ''; // Clear previous errors
    notifyListeners();

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? emailUser = userCredential.user;
      if (emailUser != null) {
        await _saveLoginState(true);

        loginEmailController.clear();
        loginPasswordController.clear();

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
              "Login Successful!",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ).show(context);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const UserTypeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? "An error occurred";

      DelightToastBar(
        snackbarDuration: const Duration(seconds: 5),
        autoDismiss: true,
        position: DelightSnackbarPosition.top,
        builder: (context) => ToastCard(
          color: AppColors.failureToastColor,
          leading: Icon(
            Icons.error,
            color: AppColors.whiteColor,
            size: 28,
          ),
          title: Text(
            _errorMessage,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ).show(context);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      await _saveLoginState(false);

      // Show success toast
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
            "Sign Out Successful!",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ).show(context);

      // Navigate to GetStartedScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const EmailAuthLoginScreen()),
      );
    } catch (e) {
      // Handle sign-out error (optional)
      DelightToastBar(
        snackbarDuration: const Duration(seconds: 5),
        autoDismiss: true,
        position: DelightSnackbarPosition.top,
        builder: (context) => ToastCard(
          color: AppColors.failureToastColor,
          leading: Icon(
            Icons.error,
            color: AppColors.whiteColor,
            size: 28,
          ),
          title: Text(
            "Sign Out Failed!",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ).show(context);
    }
  }
}
