import 'package:empprojectdemo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController textFieldController;
  final String textFieldName;
  final String hintText;
  final String simpleTextTextFieldName;
  final IconData prefixIcon;

  const MyTextField({
    super.key,
    required this.textFieldController,
    required this.textFieldName,
    required this.hintText,
    required this.simpleTextTextFieldName,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          simpleTextTextFieldName,
          style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: textFieldController,
          decoration: InputDecoration(
            labelText: textFieldName,
            labelStyle: GoogleFonts.montserrat(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: Colors.grey,
            ),
            hintText: hintText,
            hintStyle: GoogleFonts.montserrat(
              color: Colors.grey[400],
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: AppColors.subTitleColor,
                width: 2.0, // Border width
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 2.0,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
