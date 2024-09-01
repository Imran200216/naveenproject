import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/provider/authentication_provider/email_auth_provider.dart';
import 'package:empprojectdemo/screens/email_auth_login_screen.dart';
import 'package:empprojectdemo/widgets/myPasswordTextField.dart';
import 'package:empprojectdemo/widgets/mybtn.dart';
import 'package:empprojectdemo/widgets/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmailAuthRegisterScreen extends StatelessWidget {
  const EmailAuthRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EmailAuthenticationProvider>(
      builder: (
        context,
        emailAuthProvider,
        child,
      ) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          "EMS",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                      child: Text(
                        "Invisible threads are the strongest ties!",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          color: AppColors.subTitleColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/images/svg/email-auth-register-screen-img.svg",
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    /// name text field
                    MyTextField(
                      textFieldController: emailAuthProvider.nameController,
                      keyboardType: TextInputType.text,
                      hintText: "Enter your Name",
                      prefixIcon: Icons.person,
                      textFieldName: "Enter Person Name",
                      simpleTextTextFieldName: 'Enter Person Name',
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    /// email text field
                    MyTextField(
                      textFieldController:
                          emailAuthProvider.registerEmailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Enter your Email",
                      prefixIcon: Icons.mail,
                      textFieldName: "Enter Email",
                      simpleTextTextFieldName: 'Enter Email Address',
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    /// password text field
                    MyPasswordTextField(
                      textFieldName: 'Enter Password',
                      simpleTextTextFieldName: "Enter Password",
                      textFieldController:
                          emailAuthProvider.registerPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: "Enter your password",
                      prefixIcon: Icons.password,
                      fieldKey: 'passwordField',
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //// confirm password text field
                    MyPasswordTextField(
                      textFieldName: 'Enter Confirm Password',
                      simpleTextTextFieldName: "Enter Confirm Password",
                      textFieldController:
                          emailAuthProvider.registerConfirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: "Enter your Confirm password",
                      prefixIcon: Icons.password,
                      fieldKey: 'confirmPasswordField',
                    ),

                    const SizedBox(
                      height: 60,
                    ),

                    MyBtn(
                      btnTitle: "Register",
                      btnOnTap: () {
                        emailAuthProvider.registerWithEmailPassword(context);
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

                    const SizedBox(
                      height: 10,
                    ),

                    /// already have an account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.subTitleColor,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const EmailAuthLoginScreen();
                            }));
                          },
                          child: Text(
                            "Sign In Now!",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
