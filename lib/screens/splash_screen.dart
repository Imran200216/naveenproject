import 'dart:async';
import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/screens/AdminScreens/AdminBottomNavBar.dart';
import 'package:empprojectdemo/screens/EmployeeScreens/EmployeeBottomNavBar.dart';
import 'package:empprojectdemo/screens/email_auth_login_screen.dart';

import 'package:empprojectdemo/screens/user_type_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Check if the user is signed in
    final bool isSignedIn = await _checkEmailSignInStatus();

    // Set up a timer to navigate to the appropriate screen after 3 seconds
    Timer(
      const Duration(seconds: 3),
      () {
        if (!isSignedIn) {
          // If not signed in, navigate to LoginScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const EmailAuthLoginScreen(),
            ),
          );
        } else {
          // If signed in, check for personType
          _checkUserType();
        }
      },
    );
  }

  Future<bool> _checkEmailSignInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> _checkUserType() async {
    final prefs = await SharedPreferences.getInstance();
    final String? personType = prefs.getString('personType');

    if (personType == null) {
      // If personType is not selected, navigate to UserTypeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const UserTypeScreen(),
        ),
      );
    } else {
      // If personType is selected, navigate to the respective home screen
      if (personType == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AdminBottomNavBar(),
          ),
        );
      } else if (personType == 'employee') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeeBottomNavBar(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height,
      width: screenSize.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.zero,
        color: AppColors.primaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/svg/splash-logo-icon.svg",
            height: 120,
            width: 120,
            color: AppColors.whiteColor,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "EMS",
            style: GoogleFonts.montserrat(
              decoration: TextDecoration.none,
              color: AppColors.whiteColor,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
