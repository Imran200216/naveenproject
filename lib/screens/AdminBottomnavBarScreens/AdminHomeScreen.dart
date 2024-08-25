import 'package:empprojectdemo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Create Task to User",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
