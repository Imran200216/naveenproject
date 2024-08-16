import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/screens/create_employee_note_screen.dart';
import 'package:flutter/material.dart';

class EmployeeTaskScreen extends StatelessWidget {
  const EmployeeTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const CreateEmployeeNoteScreen();
            }));
          },
          child: Icon(
            Icons.task,
            color: AppColors.whiteColor,
            size: 20,
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
        ),
      ),
    );
  }
}
