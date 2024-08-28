import 'package:empprojectdemo/constants/colors.dart';

import 'package:empprojectdemo/provider/authentication_provider/google_auth_provider.dart';
import 'package:empprojectdemo/provider/employee_provider/employee_attendance_provider.dart';
import 'package:empprojectdemo/widgets/myDropdownTextField.dart';

import 'package:empprojectdemo/widgets/mybtn.dart';
import 'package:empprojectdemo/widgets/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmployeeAttendanceScreen extends StatefulWidget {
  const EmployeeAttendanceScreen({super.key});

  @override
  _EmployeeAttendanceScreenState createState() =>
      _EmployeeAttendanceScreenState();
}

class _EmployeeAttendanceScreenState extends State<EmployeeAttendanceScreen> {
  @override
  void initState() {
    super.initState();
    // Set the initial date when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EmployeeAttendanceProvider>(context, listen: false)
          .setInitialDate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<EmployeeAttendanceProvider, GoogleAuthenticationProvider>(
      builder: (
        context,
        employeeAttendanceProvider,
        googleAuthenticationProvider,
        child,
      ) {
        final user = googleAuthenticationProvider.user;
        if (user?.displayName != null) {
          employeeAttendanceProvider.setUsername(user!.displayName!);
        }

        if (user?.email != null) {
          employeeAttendanceProvider.setUserEmail(user!.email!);
        }

        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 30,
                  bottom: 30,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Employee Attendance Report",
                        style: GoogleFonts.montserrat(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(
                        height: 40,
                      ),

                      /// user name
                      MyTextField(
                        isReadOnly: true,
                        textFieldController:
                            employeeAttendanceProvider.usernameController,
                        textFieldName: "Username",
                        hintText: "Enter username",
                        simpleTextTextFieldName: "Enter Username",
                        prefixIcon: Icons.person,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      /// user email
                      MyTextField(
                        isReadOnly: true,
                        textFieldController:
                            employeeAttendanceProvider.userEmailController,
                        textFieldName: "Email",
                        hintText: "Enter email",
                        simpleTextTextFieldName: "Enter email",
                        prefixIcon: Icons.mail,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      /// current date
                      MyTextField(
                        isReadOnly: true,
                        textFieldController: employeeAttendanceProvider
                            .userCurrentAttendanceDateController,
                        textFieldName: "Present Date",
                        hintText: "Enter Date",
                        simpleTextTextFieldName: "Enter Date",
                        prefixIcon: Icons.calendar_month,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      /// Attendance text field
                      MyDropDownTextField(
                        simpleTextTextFieldName: "Attendance Status",
                        prefixIcon: Icons.check_circle,
                        items: employeeAttendanceProvider.listAttendanceStatus,
                        onChanged: (newValue) {
                          employeeAttendanceProvider.selectAttendanceStatus =
                              newValue;
                        },
                        textFieldHint: "Select attendance status",
                      ),

                      const SizedBox(
                        height: 40,
                      ),

                      /// save attendance btn
                      MyBtn(
                        btnTitle: "Save attendance report",
                        btnOnTap: () {
                          /// saving data to excel and database
                          employeeAttendanceProvider
                              .saveAttendanceReport(context);
                        },
                        imgUrl:
                            "assets/images/svg/save-attendance-document-icon.svg",
                        iconHeight: 22,
                        iconWidth: 22,
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
            ),
          ),
        );
      },
    );
  }
}
