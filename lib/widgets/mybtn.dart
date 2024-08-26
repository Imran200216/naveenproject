import 'package:empprojectdemo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBtn extends StatelessWidget {
  final String btnTitle;
  final VoidCallback btnOnTap;
  final String imgUrl;
  final double iconHeight;
  final double iconWidth;
  final double btnBorderRadius;
  final double btnHeight;
  final double btnWidth;
  final double marginLeft;
  final double marginRight;

  const MyBtn({
    super.key,
    required this.btnTitle,
    required this.btnOnTap,
    required this.imgUrl,
    required this.iconHeight,
    required this.iconWidth,
    required this.btnBorderRadius,
    required this.btnHeight,
    required this.btnWidth,
    required this.marginLeft,
    required this.marginRight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: btnOnTap,
      child: Container(
        margin: EdgeInsets.only(
          left: marginLeft,
          right: marginRight,
        ),
        height: btnHeight,
        width: btnWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(btnBorderRadius),
          color: AppColors.primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              imgUrl,
              height: iconHeight,
              width: iconWidth,
              fit: BoxFit.cover,
              color: AppColors.whiteColor,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              btnTitle,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                color: AppColors.whiteColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
