import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/screens/AdminBottomNavBar.dart';
import 'package:empprojectdemo/screens/EmployeeBottomNavBar.dart';
import 'package:empprojectdemo/widgets/mybtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                fontSize: 16,
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
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 40,
            ),

            /// Admin btn
            MyBtn(
              btnTitle: "Admin",
              btnOnTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AdminBottomNavBar();
                }));
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
              btnTitle: "Employee",
              btnOnTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EmployeeBottomNavBar();
                }));
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
    );
  }
}
