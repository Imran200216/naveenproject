import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/provider/user_type_provider.dart';
import 'package:empprojectdemo/screens/AdminScreens/AdminBottomNavBar.dart';
import 'package:empprojectdemo/screens/EmployeeScreens/EmployeeBottomNavBar.dart';
import 'package:empprojectdemo/widgets/mybtn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserTypeProvider>(
      builder: (
        context,
        userTypeProvider,
        child,
      ) {
        /// Fetch the current user's ID dynamically
        final FirebaseAuth _auth = FirebaseAuth.instance;
        User? currentUser = _auth.currentUser;
        String userId = currentUser?.uid ?? '';

        return SafeArea(
          child: Scaffold(
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
                      "assets/images/svg/admin.svg",
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
                    "Choose your EMS Status",
                    style: GoogleFonts.montserrat(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    textAlign: TextAlign.start,
                    "Enrich your capabilities through our EMS App using scheduling, tracking activities, attendances etc..,",
                    style: GoogleFonts.montserrat(
                      color: AppColors.subTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  /// Admin btn
                  MyBtn(
                    btnColor: AppColors.primaryColor,
                    btnTitle: "Admin",
                    btnOnTap: () async {
                      if (userId.isNotEmpty) {
                        await userTypeProvider
                            .updateUserType(userId, 'admin')
                            .then((value) {
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
                                "Your EMS role as Admin Success!",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ).show(context);
                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AdminBottomNavBar();
                        }));
                      } else {
                        // Handle error, e.g., show a toast message
                      }
                    },
                    imgUrl: "assets/images/svg/admin-logo-icon.svg",
                    iconHeight: 26,
                    iconWidth: 26,
                    btnBorderRadius: 6,
                    btnHeight: 50,
                    btnWidth: double.infinity,
                    marginLeft: 0,
                    marginRight: 0,
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  /// user btn
                  MyBtn(
                    btnColor: AppColors.primaryColor,
                    btnTitle: "Employee",
                    btnOnTap: () async {
                      if (userId.isNotEmpty) {
                        await userTypeProvider
                            .updateUserType(userId, 'employee')
                            .then((value) {
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
                                "Your EMS role as Employee Success!",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ).show(context);
                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return EmployeeBottomNavBar();
                        }));
                      } else {
                        // Handle error, e.g., show a toast message
                        print("User ID is not available");
                      }
                    },
                    imgUrl: "assets/images/svg/employee-logo-icon.svg",
                    iconHeight: 26,
                    iconWidth: 26,
                    btnBorderRadius: 6,
                    btnHeight: 50,
                    btnWidth: double.infinity,
                    marginLeft: 0,
                    marginRight: 0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
