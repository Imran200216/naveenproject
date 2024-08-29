import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/provider/employee_provider/employee_attendance_provider.dart';
import 'package:empprojectdemo/provider/internet_checker_provider.dart';
import 'package:empprojectdemo/provider/share_plus_provider.dart';

import 'package:empprojectdemo/widgets/mybtn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewAttendanceScreen extends StatelessWidget {
  const ViewAttendanceScreen({super.key});

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
              size: 16,
            ),
          ),
          title: const Text("View Attendance"),
          titleTextStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            color: AppColors.whiteColor,
            fontSize: 14,
          ),
        ),
        body: Consumer2<InternetCheckerProvider, ShareProvider>(
          builder: (
            context,
            internetCheckerProvider,
            shareProvider,
            child,
          ) {
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

            return Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 30, top: 30),
              child: Column(
                children: [
                  /// attendance container
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 1,
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 14,
                        right: 14,
                        top: 20,
                        bottom: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "View Pdf lively in Excel Sheet",
                            style: GoogleFonts.montserrat(
                              color: AppColors.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Text(
                            textAlign: TextAlign.start,
                            "We can access the data through google excel sheets and save time.",
                            style: GoogleFonts.montserrat(
                              color: AppColors.subTitleColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),

                          /// view attendance report
                          MyBtn(
                            btnColor: AppColors.primaryColor,
                            btnTitle: "View Attendance Report",
                            btnOnTap: () {
                              /// excel sheet employee details url
                              const excelSheetEmployeeUrl =
                                  "https://docs.google.com/spreadsheets/d/1VA2-ywQdC-nkyhhiDjXdmBhToQkOtLj5ttR1T-Szta8/edit?gid=0#gid=0";

                              /// functionality of url launcher
                              _launchUrl(
                                  Uri.parse(excelSheetEmployeeUrl), context);
                            },
                            imgUrl: "assets/images/svg/attendance-icon.svg",
                            iconHeight: 24,
                            iconWidth: 24,
                            btnBorderRadius: 6,
                            btnHeight: 46,
                            btnWidth: double.infinity,
                            marginLeft: 0,
                            marginRight: 0,
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          /// share attendance report
                          MyBtn(
                            btnColor: AppColors.shareBtnBgColor,
                            btnTitle: "Share Attendance Report",
                            btnOnTap: () {
                              /// excel sheet employee details url
                              const excelSheetEmployeeUrl =
                                  "https://docs.google.com/spreadsheets/d/1VA2-ywQdC-nkyhhiDjXdmBhToQkOtLj5ttR1T-Szta8/edit?gid=0#gid=0";

                              /// functionality of share plus
                              shareProvider.shareUrl(excelSheetEmployeeUrl);
                            },
                            imgUrl: "assets/images/svg/share-document-icon.svg",
                            iconHeight: 26,
                            iconWidth: 26,
                            btnBorderRadius: 6,
                            btnHeight: 46,
                            btnWidth: double.infinity,
                            marginLeft: 0,
                            marginRight: 0,
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          /// save the attendance report
                          MyBtn(
                            btnColor: AppColors.successToastColor,
                            btnTitle: "Save Attendance Report",
                            btnOnTap: () {},
                            imgUrl:
                                "assets/images/svg/save-attendance-document-icon.svg",
                            iconHeight: 24,
                            iconWidth: 24,
                            btnBorderRadius: 6,
                            btnHeight: 46,
                            btnWidth: double.infinity,
                            marginLeft: 0,
                            marginRight: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),

                  Expanded(
                    child: Consumer<EmployeeAttendanceProvider>(
                      builder: (
                        context,
                        employeeAttendanceProvider,
                        child,
                      ) {
                        if (employeeAttendanceProvider.isLoading) {
                          return Center(
                            child: LoadingAnimationWidget.stretchedDots(
                              color: AppColors.primaryColor,
                              size: 40,
                            ),
                          );
                        } else if (employeeAttendanceProvider.errorMessage !=
                            null) {
                          return Center(
                            child: Text(
                              employeeAttendanceProvider.errorMessage!,
                              style: GoogleFonts.montserrat(
                                color: AppColors.subTitleColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          );
                        } else if (employeeAttendanceProvider
                            .attendanceList.isEmpty) {
                          return Center(
                            child: Text(
                              'No attendance records found.',
                              style: GoogleFonts.montserrat(
                                color: AppColors.subTitleColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: employeeAttendanceProvider
                                .attendanceList.length,
                            itemBuilder: (context, index) {
                              final employee = employeeAttendanceProvider
                                  .attendanceList[index];
                              return ListTile(
                                title: Text(
                                  employee.name,
                                ),
                                subtitle: Text(
                                    'Status: ${employee.attendanceStatus} on ${employee.currentDate}'),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// this function is for url launcher does not responds
  Future<void> _launchUrl(Uri url, BuildContext context) async {
    if (!await launchUrl(url)) {
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
            "Url launch failed!",
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
