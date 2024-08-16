import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/screens/user_type_screen.dart';
import 'package:empprojectdemo/widgets/mybtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SvgPicture.asset(
                "assets/images/svg/login.svg",
                height: 300,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              textAlign: TextAlign.start,
              "Let's Login to our EMS App to track our daily activities",
              style: GoogleFonts.montserrat(
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              textAlign: TextAlign.start,
              "Registered users can log in to the app using their credentials. Upon successful login, the user is authenticated and granted access to the app's features.",
              style: GoogleFonts.montserrat(
                color: AppColors.subTitleColor,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            MyBtn(
              btnTitle: "Sign in with Google",
              btnOnTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const UserTypeScreen();
                }));
              },
              imgUrl: "assets/images/svg/google-login-icon.svg",
              iconHeight: 20,
              iconWidth: 20,
              btnBorderRadius: 6,
              btnHeight: 50,
              btnWidth: double.infinity,
              marginLeft: 0,
              marginRight: 0,
            ),
          ],
        ),
      ),
    );
  }
}
