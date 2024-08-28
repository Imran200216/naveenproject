import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:empprojectdemo/api/employee_sheets_api.dart';
import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/modals/EmployeeAttendanceModel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
            "Attendance recorded successfully!",
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

  ///////////////  Task name fixation //////////////////

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController userEmailController = TextEditingController();

  final TextEditingController userCurrentAttendanceDateController =
      TextEditingController();

  void setUsername(String userName) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      usernameController.text = userName;
      notifyListeners();
    });
  }

  void setUserEmail(String userEmail) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userEmailController.text = userEmail;
      notifyListeners();
    });
  }

  void setInitialDate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String formattedDate =
          DateFormat('yyyy-MM-dd').format(DateTime.now());
      userCurrentAttendanceDateController.text = formattedDate;
      notifyListeners();
    });
  }

  String? selectAttendanceStatus;
  final List<String> listAttendanceStatus = [
    "Present",
    "Absent",
    "On leave",
  ];

  ///////////////////  saving the data to database and excel sheets   ////////////////////

  Future<void> saveAttendanceReport(BuildContext context) async {
    final today = DateTime.now()
        .toIso8601String()
        .split('T')
        .first; // Get today's date in YYYY-MM-DD format
    final employeeEmail = userEmailController.text;

    // Check if an attendance record for today already exists for the employee
    final querySnapshot = await FirebaseFirestore.instance
        .collection("employeeAttendanceDetails")
        .where('email', isEqualTo: employeeEmail)
        .where('currentDate', isEqualTo: today)
        .get();

    if (querySnapshot.docs.isEmpty) {
      // No existing record for today, proceed to add new attendance
      final employeeAttendanceDetails = Employee(
        name: usernameController.text,
        email: employeeEmail,
        attendanceStatus: selectAttendanceStatus.toString(),
        currentDate: today,
      );

      await addEmployeeAttendance(
          [employeeAttendanceDetails.toJson()], context);

      await FirebaseFirestore.instance
          .collection("employeeAttendanceDetails")
          .add(employeeAttendanceDetails
              .toJson()); // Add directly as Map<String, dynamic>

      // Add to Google Sheets if needed here
    } else {
      // Show message or handle the case where attendance already recorded
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Attendance Already Recorded',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
              fontSize: 14,
            ),
          ),
          content: Text(
            'You have already recorded your attendance for today.',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: AppColors.subTitleColor,
              fontSize: 12,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
