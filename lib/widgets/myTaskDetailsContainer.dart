import 'package:empprojectdemo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTaskDetailsContainer extends StatelessWidget {
  final String taskValue;

  const MyTaskDetailsContainer({
    super.key,
    required this.taskValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.taskTileBgColor,
        border: Border.all(
          color: AppColors.primaryColor,
          width: 1,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(
          left: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              taskValue,
              style: GoogleFonts.montserrat(
                color: AppColors.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
