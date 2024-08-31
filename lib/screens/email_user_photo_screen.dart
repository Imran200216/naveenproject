import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/provider/user_image_provider.dart';
import 'package:empprojectdemo/screens/user_type_screen.dart';
import 'package:empprojectdemo/widgets/mybtn.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmailUserPhotoScreen extends StatelessWidget {
  final String uid;

  const EmailUserPhotoScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<UserImageProvider>(
          builder: (
            context,
            userImageProvider,
            child,
          ) {
            return Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 30,
                bottom: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    "Pick image for the user",
                    style: GoogleFonts.montserrat(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  userImageProvider.image != null
                      ? CircleAvatar(
                          radius: 200,
                          backgroundImage: FileImage(userImageProvider.image!),
                        )
                      : Center(
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
                        ),
                  const SizedBox(
                    height: 80,
                  ),

                  /// pick image from camera
                  MyBtn(
                    btnColor: AppColors.primaryColor,
                    btnTitle: "Pick image from camera",
                    btnOnTap: () {
                      userImageProvider.pickImageFromCamera(uid).then((value) {
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
                              "Profile success!",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ).show(context);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserTypeScreen()));
                      });
                    },
                    imgUrl: "assets/images/svg/create-task-icon.svg",
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
                      userImageProvider.pickImageFromGallery(uid).then((value) {
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
                              "Profile success!",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ).show(context);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserTypeScreen()));
                      });
                    },
                    imgUrl: "assets/images/svg/create-task-icon.svg",
                    iconHeight: 26,
                    iconWidth: 26,
                    btnBorderRadius: 4,
                    btnHeight: 50,
                    btnWidth: double.infinity,
                    marginLeft: 0,
                    marginRight: 0,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
