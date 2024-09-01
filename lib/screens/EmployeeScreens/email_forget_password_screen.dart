import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/provider/authentication_provider/email_auth_provider.dart';
import 'package:empprojectdemo/widgets/mybtn.dart';
import 'package:empprojectdemo/widgets/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmailForgetPasswordScreen extends StatelessWidget {
  const EmailForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.whiteColor,
            ),
          ),
          title: const Text("Forget Password"),
          titleTextStyle: GoogleFonts.montserrat(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        body: Consumer<EmailAuthenticationProvider>(
          builder: (
            context,
            emailAuthProvider,
            child,
          ) {
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 30,
                  top: 30,
                ),
                child: Column(
                  children: [
                    Text(
                      "Enter your Email and we will send you a password reset link",
                      style: GoogleFonts.montserrat(
                        color: AppColors.subTitleColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: SvgPicture.asset(
                        "assets/images/svg/reset-password.svg",
                        height: 300,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    /// email text field for forget password
                    MyTextField(
                      textFieldController:
                          emailAuthProvider.forgetPasswordEmailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Enter your email",
                      prefixIcon: Icons.mail,
                      simpleTextTextFieldName: 'Enter Email Address',
                      textFieldName: 'Enter Email',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyBtn(
                      btnTitle: "Reset Password",
                      btnOnTap: () {
                        /// forget password functionality
                        emailAuthProvider.resetPassword(context);
                      },
                      imgUrl: "assets/images/svg/login-icon.svg",
                      iconHeight: 30,
                      iconWidth: 30,
                      btnBorderRadius: 6,
                      btnHeight: 60,
                      btnWidth: double.infinity,
                      marginLeft: 0,
                      marginRight: 0,
                      btnColor: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
