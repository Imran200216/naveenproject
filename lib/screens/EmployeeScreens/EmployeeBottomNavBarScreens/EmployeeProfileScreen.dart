import 'package:cached_network_image/cached_network_image.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/provider/authentication_provider/email_auth_provider.dart';

import 'package:empprojectdemo/provider/internet_checker_provider.dart';
import 'package:empprojectdemo/provider/user_image_provider.dart';
import 'package:empprojectdemo/screens/EmployeeScreens/employee_about_app_screen.dart';
import 'package:empprojectdemo/widgets/mybtn.dart';

import 'package:empprojectdemo/widgets/myprofilecard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class EmployeeProfileScreen extends StatelessWidget {
  const EmployeeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<EmailAuthenticationProvider, InternetCheckerProvider,
        UserImageProvider>(
      builder: (
        context,
        emailAuthProvider,
        internetCheckerProvider,
        userImageProvider,
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

        if (user == null) {
          // User data is still loading
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }

        return Scaffold(
          body: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: userImageProvider.image != null
                            ? FileImage(userImageProvider.image!)
                            : (user.photoURL != null
                                    ? CachedNetworkImageProvider(user.photoURL!)
                                    : const AssetImage(
                                        "assets/images/png/nouser-img.png"))
                                as ImageProvider,
                        child: userImageProvider.image == null &&
                                user.photoURL == null
                            ? Center(
                                child: DottedBorder(
                                  borderType: BorderType.Circle,
                                  dashPattern: const [6, 6],
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(300),
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      color: AppColors.taskTileBgColor,
                                      child: Center(
                                        child: Icon(
                                          Icons.person,
                                          size: 80,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : null,
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: () {
                            /// bottom modal sheet for accessing the profile pic from gallery and camera
                            showModalBottomSheet(
                                context: context,
                                isDismissible: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                builder: (context) {
                                  return Container(
                                    margin: const EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                      top: 20,
                                      bottom: 20,
                                    ),
                                    height: 300,
                                    child: Column(
                                      children: [
                                        Text(
                                          "Let's update the profile",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),

                                        /// pick image from camera
                                        MyBtn(
                                          btnColor: AppColors.primaryColor,
                                          btnTitle: "Pick image from camera",
                                          btnOnTap: () {
                                            userImageProvider
                                                .pickImageFromCamera(user.uid)
                                                .then((success) {
                                              if (success) {
                                                // Show success toast
                                                DelightToastBar(
                                                  snackbarDuration:
                                                      const Duration(
                                                          seconds: 5),
                                                  autoDismiss: true,
                                                  position:
                                                      DelightSnackbarPosition
                                                          .top,
                                                  builder: (context) =>
                                                      ToastCard(
                                                    color: AppColors
                                                        .successToastColor,
                                                    leading: SvgPicture.asset(
                                                      "assets/images/svg/auth-success-icon.svg",
                                                      height: 28,
                                                      width: 28,
                                                      fit: BoxFit.cover,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                    title: Text(
                                                      "Profile updated successfully!",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                        color: AppColors
                                                            .whiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                ).show(context);
                                                Navigator.pop(context);
                                              } else {
                                                // Show failure toast
                                                DelightToastBar(
                                                  snackbarDuration:
                                                      const Duration(
                                                          seconds: 5),
                                                  autoDismiss: true,
                                                  position:
                                                      DelightSnackbarPosition
                                                          .top,
                                                  builder: (context) =>
                                                      ToastCard(
                                                    color: AppColors
                                                        .failureToastColor,
                                                    leading: Icon(
                                                      Icons.error,
                                                      color:
                                                          AppColors.whiteColor,
                                                      size: 28,
                                                    ),
                                                    title: Text(
                                                      "Failed to update profile!",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                        color: AppColors
                                                            .whiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                ).show(context);
                                                Navigator.pop(context);
                                              }
                                            });
                                          },
                                          imgUrl:
                                              "assets/images/svg/camera-icon.svg",
                                          iconHeight: 26,
                                          iconWidth: 26,
                                          btnBorderRadius: 4,
                                          btnHeight: 50,
                                          btnWidth: double.infinity,
                                          marginLeft: 0,
                                          marginRight: 0,
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),

                                        /// pick image from gallery
                                        MyBtn(
                                          btnColor: AppColors.primaryColor,
                                          btnTitle: "Pick image from gallery",
                                          btnOnTap: () {
                                            userImageProvider
                                                .pickImageFromGallery(user.uid)
                                                .then(
                                              (success) {
                                                if (success) {
                                                  // Show success toast
                                                  DelightToastBar(
                                                    snackbarDuration:
                                                        const Duration(
                                                            seconds: 5),
                                                    autoDismiss: true,
                                                    position:
                                                        DelightSnackbarPosition
                                                            .top,
                                                    builder: (context) =>
                                                        ToastCard(
                                                      color: AppColors
                                                          .successToastColor,
                                                      leading: SvgPicture.asset(
                                                        "assets/images/svg/auth-success-icon.svg",
                                                        height: 28,
                                                        width: 28,
                                                        fit: BoxFit.cover,
                                                        color: AppColors
                                                            .whiteColor,
                                                      ),
                                                      title: Text(
                                                        "Profile updated successfully!",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: AppColors
                                                              .whiteColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ).show(context);
                                                } else {
                                                  // Show failure toast
                                                  DelightToastBar(
                                                    snackbarDuration:
                                                        const Duration(
                                                            seconds: 5),
                                                    autoDismiss: true,
                                                    position:
                                                        DelightSnackbarPosition
                                                            .top,
                                                    builder: (context) =>
                                                        ToastCard(
                                                      color: AppColors
                                                          .failureToastColor,
                                                      leading: Icon(
                                                        Icons.error,
                                                        color: AppColors
                                                            .whiteColor,
                                                        size: 28,
                                                      ),
                                                      title: Text(
                                                        "Failed to update profile!",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: AppColors
                                                              .whiteColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ).show(context);
                                                }
                                              },
                                            );
                                          },
                                          imgUrl:
                                              "assets/images/svg/gallery-icon.svg",
                                          iconHeight: 26,
                                          iconWidth: 26,
                                          btnBorderRadius: 4,
                                          btnHeight: 50,
                                          btnWidth: double.infinity,
                                          marginLeft: 0,
                                          marginRight: 0,
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add_a_photo,
                                size: 30,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "${user.displayName}",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),

                /// user type
                Text(
                  "Employee",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 8),
                // Person email address
                Text(
                  "${user.email}",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: AppColors.subTitleColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                MyProfileCard(
                  cardIcon: Icons.person,
                  cardTitle: "About app",
                  cardOnTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const EmployeeAboutAppScreen();
                    }));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),

                MyProfileCard(
                  cardIcon: Icons.logout,
                  cardTitle: "Sign out",
                  cardOnTap: () {
                    emailAuthProvider.signOut(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
