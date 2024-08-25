import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/provider/admin_provider/admin_task_provider.dart';
import 'package:empprojectdemo/widgets/mybtn.dart';
import 'package:empprojectdemo/widgets/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminTaskScreen extends StatelessWidget {
  const AdminTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminTaskProvider>(
      builder: (
        context,
        adminTaskProvider,
        child,
      ) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// create task to employee
                    Text(
                      "Create task to employee",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    /// task name
                    MyTextField(
                      prefixIcon: Icons.task,
                      textFieldController: adminTaskProvider.taskNameController,
                      textFieldName: "Task Name",
                      hintText: "Create task name",
                      simpleTextTextFieldName: "Task Name",
                    ),

                    /// task assigned to the person
                    MyTextField(
                      prefixIcon: Icons.person,
                      textFieldController:
                          adminTaskProvider.taskAssignedPersonController,
                      textFieldName: "Task Assigned Person",
                      hintText: "Task assigned",
                      simpleTextTextFieldName: "Task Assigned Person",
                    ),

                    /// Task given by the person
                    MyTextField(
                      prefixIcon: Icons.person,
                      textFieldController:
                          adminTaskProvider.taskGivenPersonController,
                      textFieldName: "Task Given Person",
                      hintText: "Task given person",
                      simpleTextTextFieldName: "Task Given Person",
                    ),

                    /// Start Date Text field
                    MyTextField(
                      prefixIcon: Icons.date_range,
                      textFieldController:
                          adminTaskProvider.startDateTimeController,
                      textFieldName: "Task Started Date",
                      hintText: "Task started date",
                      simpleTextTextFieldName: "Task Started Date",
                    ),

                    /// End Date Text field
                    MyTextField(
                      prefixIcon: Icons.date_range,
                      textFieldController:
                          adminTaskProvider.dueDateTimeController,
                      textFieldName: "Task Due Date",
                      hintText: "Task due date",
                      simpleTextTextFieldName: "Task Due Date",
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    /// add task btn to user
                    MyBtn(
                      btnTitle: "Add Task To User",
                      btnOnTap: () {},
                      imgUrl: "assets/images/svg/create-task-icon.svg",
                      iconHeight: 26,
                      iconWidth: 26,
                      btnBorderRadius: 4,
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
