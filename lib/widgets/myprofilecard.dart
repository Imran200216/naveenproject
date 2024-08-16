import 'package:empprojectdemo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileCard extends StatelessWidget {
  final IconData cardIcon;
  final String cardTitle;
  final VoidCallback cardOnTap;

  const MyProfileCard({
    super.key,
    required this.cardIcon,
    required this.cardTitle,
    required this.cardOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      child: ListTile(
        onTap: cardOnTap,
        leading: Icon(
          cardIcon,
          color: AppColors.primaryColor,
          size: 16,
        ),
        title: Text(
          cardTitle,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
