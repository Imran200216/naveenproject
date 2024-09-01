import 'package:empprojectdemo/constants/colors.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        body: Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 30,
            top: 30,
          ),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
