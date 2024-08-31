import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/provider/authentication_provider/email_auth_provider.dart';
import 'package:empprojectdemo/screens/EmployeeScreens/email_forget_password_screen.dart';
import 'package:empprojectdemo/screens/email_auth_register_screen.dart';
import 'package:empprojectdemo/widgets/myPasswordTextField.dart';
import 'package:empprojectdemo/widgets/mybtn.dart';
import 'package:empprojectdemo/widgets/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmailAuthLoginScreen extends StatelessWidget {
  const EmailAuthLoginScreen({super.key});

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
            body: Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 180,
                      child: Text(
                        "EMS",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                          fontSize: 30,
                        ),
                      ),
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
                      child: SvgPicture.asset(
                        "assets/images/svg/email-auth-login-screen-img.svg",
                        height: 300,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    /// email text field
                    MyTextField(
                      textFieldController:
                          emailAuthProvider.loginEmailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Enter your email",
                      prefixIcon: Icons.mail,
                      simpleTextTextFieldName: 'Enter Email Address',
                      textFieldName: 'Enter Email',
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    /// password text field
                    MyPasswordTextField(
                      textFieldController:
                          emailAuthProvider.loginPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: "Enter your password",
                      prefixIcon: Icons.password,
                      fieldKey: 'passwordField',
                      simpleTextTextFieldName: 'Enter Password',
                      textFieldName: 'Enter Password', // Unique key
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    /// forget password btn
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return const EmailForgetPasswordScreen();
                            }));
                          },
                          child: Text(
                            "Forget Password?",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    /// don't have an account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
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
                              return const EmailAuthRegisterScreen();
                            }));
                          },
                          child: Text(
                            "Sign Up Now!",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 40,
                    ),
                    MyBtn(
                      btnTitle: "Login",
                      btnOnTap: () {
                        /// login functionality
                        emailAuthProvider.loginWithEmailPassword(context);
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
            ),
          ),
        );
      },
    );
  }
}
