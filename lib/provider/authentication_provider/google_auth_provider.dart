import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/screens/login_screen.dart';
import 'package:empprojectdemo/screens/user_type_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleAuthenticationProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? _user;

  User? get user => _user;

  bool _isSigningIn = false;

  bool get isSigningIn => _isSigningIn;

  GoogleAuthenticationProvider() {
    _user = _auth.currentUser;
  }

  /// sign in with google authentication
  Future<void> signInWithGoogle(BuildContext context) async {
    _isSigningIn = true;
    notifyListeners();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _isSigningIn = false;
        notifyListeners();
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      _user = userCredential.user;

      // Save user data to Fire store
      await _saveUserDataToFirestore(_user);

      DelightToastBar(
        position: DelightSnackbarPosition.top,
        autoDismiss: true,
        snackbarDuration: const Duration(seconds: 5),
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
            "Authentication Successful!",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ).show(context);

      // Save sign-in status to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isSignedIn', true);

      // Navigate to user type screen if sign-in is successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const UserTypeScreen(),
        ),
      );
    } catch (e) {
      print("/////////////////////////////////////////////////////");
      print(e);

      DelightToastBar(
        position: DelightSnackbarPosition.top,
        autoDismiss: true,
        snackbarDuration: const Duration(seconds: 5),
        builder: (context) => ToastCard(
          color: AppColors.failureToastColor,
          leading: Icon(
            Icons.error,
            color: AppColors.whiteColor,
            size: 28,
          ),
          title: Text(
            "Authentication Failed!",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ).show(context);
    } finally {
      _isSigningIn = false;
      notifyListeners();
    }
  }

  Future<void> _saveUserDataToFirestore(User? user) async {
    if (user == null) return;

    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('user');

    final userData = {
      'uid': user.uid,
      'name': user.displayName,
      'email': user.email,
      'photoURL': user.photoURL,
    };

    await usersCollection.doc(user.uid).set(userData);
  }

  /// sign out with google authentication
  Future<void> signOutWithGoogle(BuildContext context) async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      _user = null;
      notifyListeners();

      /// Clear sign-in status from shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('isSignedIn');

      /// Show Delight Toast for successful sign-out
      DelightToastBar(
        position: DelightSnackbarPosition.top,
        autoDismiss: true,
        snackbarDuration: const Duration(seconds: 5),
        builder: (context) => ToastCard(
          color: AppColors.successToastColor,
          leading: Icon(
            Icons.logout,
            color: AppColors.whiteColor,
            size: 28,
          ),
          title: Text(
            "Sign Out Successfully!",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ).show(context);

      /// Navigate to the AuthenticationScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } catch (e) {
      print(e);

      DelightToastBar(
        snackbarDuration: const Duration(seconds: 5),
        autoDismiss: true,
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
