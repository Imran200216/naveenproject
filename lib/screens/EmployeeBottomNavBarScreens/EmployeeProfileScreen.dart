import 'package:cached_network_image/cached_network_image.dart';
import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/provider/authentication_provider/google_auth_provider.dart';
import 'package:empprojectdemo/provider/internet_checker_provider.dart';
import 'package:empprojectdemo/widgets/myprofilecard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class EmployeeProfileScreen extends StatelessWidget {
  const EmployeeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<GoogleAuthenticationProvider, InternetCheckerProvider>(
      builder: (
        context,
        googleAuthProvider,
        internetCheckerProvider,
        child,
      ) {
        final user = googleAuthProvider.user;

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
                  child: Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500),
                      image: DecorationImage(
                        image: user.photoURL != null
                            ? CachedNetworkImageProvider(
                                user.photoURL!,
                              )
                            : const AssetImage(
                                "assets/images/png/nouser-img.png",
                              ),
                        fit: BoxFit.cover,
                      ),
                    ),
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
                  "User",
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
                  cardOnTap: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                MyProfileCard(
                  cardIcon: Icons.details,
                  cardTitle: "Personal details",
                  cardOnTap: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                MyProfileCard(
                  cardIcon: Icons.logout,
                  cardTitle: "Sign out",
                  cardOnTap: () {
                    googleAuthProvider.signOutWithGoogle(context);
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
