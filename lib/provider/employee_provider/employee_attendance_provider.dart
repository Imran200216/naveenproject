import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:empprojectdemo/api/employee_sheets_api.dart';
import 'package:empprojectdemo/constants/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EmployeeAttendanceProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  EmployeeAttendanceProvider() {
    _initSheets();
  }

  Future<void> _initSheets() async {
    try {
      _setLoading(true);
      await UserSheetsApi.init();
    } catch (e) {
      _setErrorMessage("Failed to initialize Google Sheets");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addEmployeeAttendance(
      List<Map<String, dynamic>> attendanceData, BuildContext context) async {
    try {
      _setLoading(true);
      await UserSheetsApi.insert(attendanceData);

      /// show success toast
      DelightToastBar(
        position: DelightSnackbarPosition.top,
        autoDismiss: true,
        snackbarDuration: const Duration(seconds: 5),
        builder: (context) => ToastCard(
          color: AppColors.successToastColor,
          leading: SvgPicture.asset(
            "assets/images/svg/auth-success-icon.svg",
            height: 28,
            width: 28,
            fit: BoxFit.cover,
            color: AppColors.whiteColor,
          ),
          title: Text(
            "Attendance added successfully!",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ).show(context);

      notifyListeners();

      _setErrorMessage(null);
    } catch (e) {
      _setErrorMessage("Failed to add employee attendance data");
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }
}
