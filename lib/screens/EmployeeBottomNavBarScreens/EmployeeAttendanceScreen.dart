import 'package:empprojectdemo/modals/EmployeeAttendanceModel.dart';
import 'package:empprojectdemo/provider/employee_provider/employee_attendance_provider.dart';
import 'package:empprojectdemo/widgets/mybtn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeAttendanceScreen extends StatelessWidget {
  const EmployeeAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeAttendanceProvider>(
      builder: (
        context,
        employeeAttendanceProvider,
        child,
      ) {
        return SafeArea(
          child: Scaffold(
            body: Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 30,
                bottom: 30,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyBtn(
                      btnTitle: "Save fields",
                      btnOnTap: () async {
                        final user = Employee(
                          name: "Imran",
                          email: "imranfreakz@gmail.com",
                          isPresentOrAbsent: true,
                        );

                        await employeeAttendanceProvider
                            .addEmployeeAttendance([user.toJson()], context);
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
        );
      },
    );
  }
}
