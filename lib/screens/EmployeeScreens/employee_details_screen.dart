import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/provider/authentication_provider/email_auth_provider.dart';
import 'package:empprojectdemo/provider/employee_provider/more_details_employee_provider.dart';
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
    // Fetch employee details when the widget is built
    final moreDetailsProvider =
        Provider.of<MoreDetailsEmployeeFieldsProvider>(context);
    final emailAuthProvider = Provider.of<EmailAuthenticationProvider>(context);
    final internetCheckerProvider =
        Provider.of<InternetCheckerProvider>(context);

    // Trigger fetching employee details if not already fetched
    if (!moreDetailsProvider.isUpdatedFetched) {
      moreDetailsProvider.fetchEmployeeDetailsForCurrentUser(context);
    }

    final user = emailAuthProvider.emailUser;

    return Scaffold(
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
      body: internetCheckerProvider.isNetworkConnected
          ? SingleChildScrollView(
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
                    _buildDetailItem("Name", user?.displayName ?? "N/A"),
                    _buildDetailItem("Email Address", user?.email ?? "N/A"),
                    _buildDetailItem("Employee Id", user?.uid ?? "N/A"),
                    if (moreDetailsProvider.isUpdatedFetched &&
                        moreDetailsProvider.userDetails != null) ...[
                      _buildDetailItem("Employee Age",
                          moreDetailsProvider.userDetails!['age'] ?? "N/A"),
                      _buildDetailItem(
                          "Designation",
                          moreDetailsProvider.userDetails!['designation'] ??
                              "N/A"),
                      _buildDetailItem(
                          "Work Experience",
                          moreDetailsProvider.userDetails!['workExperience'] ??
                              "N/A"),
                      _buildDetailItem("Address",
                          moreDetailsProvider.userDetails!['address'] ?? "N/A"),
                    ],
                    const SizedBox(height: 50),
                    if (!moreDetailsProvider.isUpdatedFetched)
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
                      )
                    else
                      const SizedBox(),
                  ],
                ),
              ),
            )
          : Center(
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
            ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
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
          taskValue: value,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
