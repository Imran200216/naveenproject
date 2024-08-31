import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/provider/password_visibility_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyPasswordTextField extends StatelessWidget {
  final TextEditingController textFieldController;
  final String textFieldName;
  final String hintText;
  final String simpleTextTextFieldName;
  final IconData prefixIcon;
  final VoidCallback? onTap;
  final bool isReadOnly;
  final VoidCallback? onSuffixTap;
  final TextInputType? keyboardType;
  final String fieldKey;

  const MyPasswordTextField({
    super.key,
    required this.textFieldController,
    required this.textFieldName,
    required this.hintText,
    required this.simpleTextTextFieldName,
    required this.prefixIcon,
    this.onTap,
    this.isReadOnly = false,
    this.onSuffixTap,
    this.keyboardType,
    required this.fieldKey,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PasswordVisibilityProvider>(
      builder: (context, passwordVisibilityProvider, child) {
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
              obscureText: passwordVisibilityProvider.isObscure(fieldKey),
              keyboardType: keyboardType,
              readOnly: isReadOnly,
              onTap: onTap,
              style: GoogleFonts.montserrat(
                color: AppColors.blackColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              controller: textFieldController,
              decoration: InputDecoration(
                labelText: textFieldName,
                labelStyle: GoogleFonts.montserrat(
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Icon(
                  prefixIcon,
                  color: AppColors.greyColor,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisibilityProvider.isObscure(fieldKey)
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () =>
                      passwordVisibilityProvider.toggleVisibility(fieldKey),
                  color: passwordVisibilityProvider.isObscure(fieldKey)
                      ? AppColors.subTitleColor
                      : AppColors.primaryColor,
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
      },
    );
  }
}
