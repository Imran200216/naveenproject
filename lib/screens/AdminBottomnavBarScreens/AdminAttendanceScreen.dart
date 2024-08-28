import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/widgets/mybtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminAttendanceScreen extends StatelessWidget {
  const AdminAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SvgPicture.asset(
                  "assets/images/svg/attendance.svg",
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "View employee details",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                textAlign: TextAlign.start,
                "Helps to view the attendance of the employee and give you an clear idea",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  color: AppColors.subTitleColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              MyBtn(
                btnTitle: "View Attendance",
                btnOnTap: () {},
                imgUrl: "assets/images/svg/task-icon.svg",
                iconHeight: 24,
                iconWidth: 24,
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
  }
}
