import 'package:empprojectdemo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDropDownTextField extends StatelessWidget {
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final String textFieldHint;
  final String simpleTextTextFieldName;
  final IconData prefixIcon;

  const MyDropDownTextField({
    super.key,
    required this.items,
    this.value,
    required this.onChanged,
    required this.textFieldHint,
    required this.prefixIcon,
    required this.simpleTextTextFieldName,
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
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButtonFormField<String>(
            style: GoogleFonts.montserrat(
              color: AppColors.blackColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
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
              contentPadding: const EdgeInsets.all(15),
              prefixIcon: Icon(
                prefixIcon,
                color: AppColors.greyColor,
              ),
            ),
            hint: Text(textFieldHint),
            icon: Icon(
              Icons.arrow_drop_down_circle_rounded,
              color: AppColors.primaryColor,
            ),
            value: value,
            isExpanded: true,
            items: items.map((String valueItem) {
              return DropdownMenuItem<String>(
                value: valueItem,
                child: Text(
                  valueItem,
                  style: GoogleFonts.montserrat(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
