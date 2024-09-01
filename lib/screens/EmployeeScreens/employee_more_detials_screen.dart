import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/provider/authentication_provider/email_auth_provider.dart';
import 'package:empprojectdemo/provider/employee_provider/more_details_employee_provider.dart';
import 'package:empprojectdemo/screens/EmployeeScreens/employee_details_screen.dart';
import 'package:empprojectdemo/widgets/mybtn.dart';
import 'package:empprojectdemo/widgets/mytextfield.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmployeeMoreDetailsScreen extends StatelessWidget {
  const EmployeeMoreDetailsScreen({super.key});

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
          title: const Text("Employee More Details"),
          titleTextStyle: GoogleFonts.montserrat(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        body: Consumer2<MoreDetailsEmployeeFieldsProvider,
            EmailAuthenticationProvider>(
          builder: (
            context,
            moreDetailsEmployeeFieldsProvider,
            emailAuthProvider,
            child,
          ) {
            final user = emailAuthProvider.emailUser;

            return Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 30,
                top: 30,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// employee age
                    MyTextField(
                      keyboardType: TextInputType.number,
                      textFieldController: moreDetailsEmployeeFieldsProvider
                          .ageEmployeeController,
                      textFieldName: "Enter Age",
                      hintText: "Enter Age",
                      simpleTextTextFieldName: "Enter Age",
                      prefixIcon: Icons.person,
                    ),

                    /// employee designation
                    MyTextField(
                      textFieldController: moreDetailsEmployeeFieldsProvider
                          .designationEmployeeController,
                      textFieldName: "Enter Designation",
                      hintText: "Enter Designation",
                      simpleTextTextFieldName: "Enter Designation",
                      prefixIcon: Icons.school,
                    ),

                    /// employee work experience
                    MyTextField(
                      keyboardType: TextInputType.number,
                      textFieldController: moreDetailsEmployeeFieldsProvider
                          .workExperienceEmployeeController,
                      textFieldName: "Enter Work Experience",
                      hintText: "Enter Experience",
                      simpleTextTextFieldName: "Enter Experience",
                      prefixIcon: Icons.school,
                    ),

                    /// employee address
                    MyTextField(
                      textFieldController: moreDetailsEmployeeFieldsProvider
                          .addressEmployeeController,
                      textFieldName: "Enter Address",
                      hintText: "Enter Address",
                      simpleTextTextFieldName: "Enter Address",
                      prefixIcon: Icons.location_city,
                    ),

                    const SizedBox(
                      height: 60,
                    ),

                    MyBtn(
                      btnTitle: "Add Employee Details",
                      btnOnTap: () {
                        /// add additional details functionality
                        moreDetailsEmployeeFieldsProvider
                            .updateEmployeeDetails(user!.uid)
                            .then((value) {
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
                                "Profile updated successfully!",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ).show(context);

                          /// clearing all text editing controllers
                          moreDetailsEmployeeFieldsProvider
                              .ageEmployeeController
                              .clear();
                          moreDetailsEmployeeFieldsProvider
                              .addressEmployeeController
                              .clear();
                          moreDetailsEmployeeFieldsProvider
                              .designationEmployeeController
                              .clear();
                          moreDetailsEmployeeFieldsProvider
                              .workExperienceEmployeeController
                              .clear();

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const EmployeeDetailsScreen();
                          }));
                        });
                      },
                      imgUrl: "assets/images/svg/task-icon.svg",
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
