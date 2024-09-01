import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/provider/authentication_provider/email_auth_provider.dart';
import 'package:empprojectdemo/provider/internet_checker_provider.dart';
import 'package:empprojectdemo/screens/EmployeeScreens/employee_more_detials_screen.dart';
import 'package:empprojectdemo/widgets/myTaskDetailsContainer.dart';
import 'package:empprojectdemo/widgets/mybtn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  const EmployeeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.whiteColor,
              size: 20,
            ),
          ),
          title: const Text("Employee Details"),
          titleTextStyle: GoogleFonts.montserrat(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        body: Consumer2<EmailAuthenticationProvider, InternetCheckerProvider>(
          builder: (
            context,
            emailAuthProvider,
            internetCheckerProvider,
            child,
          ) {
            final user = emailAuthProvider.emailUser;

            if (!internetCheckerProvider.isNetworkConnected) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/images/lottie/no-internet-connection-animation.json",
                      height: 240,
                      width: 240,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      "No Internet Connection",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.subTitleColor,
                      ),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 30,
                  top: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: GoogleFonts.montserrat(
                        color: AppColors.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTaskDetailsContainer(
                      taskValue: user!.displayName.toString(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Email Address",
                      style: GoogleFonts.montserrat(
                        color: AppColors.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTaskDetailsContainer(
                      taskValue: user.email.toString(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Employee Id",
                      style: GoogleFonts.montserrat(
                        color: AppColors.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTaskDetailsContainer(
                      taskValue: user.uid.toString(),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    MyBtn(
                      btnTitle: "Add more details of employee",
                      btnOnTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const EmployeeMoreDetailsScreen();
                        }));
                      },
                      imgUrl: "assets/images/svg/more-icon.svg",
                      iconHeight: 24,
                      iconWidth: 24,
                      btnBorderRadius: 6,
                      btnHeight: 50,
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
