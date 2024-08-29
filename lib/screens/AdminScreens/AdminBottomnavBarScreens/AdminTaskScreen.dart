import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/provider/admin_provider/admin_task_provider.dart';
import 'package:empprojectdemo/widgets/mybtn.dart';
import 'package:empprojectdemo/widgets/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

                    /// add the image to the task
                    InkWell(
                      onTap: () async {
                        // Pick image functionality
                        await adminTaskProvider.pickImages();

                        if (adminTaskProvider.pageViewItems.isNotEmpty) {
                          adminTaskProvider.pageController.jumpToPage(1);
                        }
                      },
                      child: SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: PageView.builder(
                          controller: adminTaskProvider.pageController,
                          itemCount: adminTaskProvider.pageViewItems.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return adminTaskProvider.pageViewItems[index];
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    adminTaskProvider.selectedImages.isEmpty
                        ? const SizedBox()
                        : Center(
                            child: SmoothPageIndicator(
                              controller: adminTaskProvider.pageController,
                              count: adminTaskProvider.pageViewItems.length,
                              effect: WormEffect(
                                activeDotColor: AppColors.primaryColor,
                                dotColor: AppColors.subTitleColor,
                                dotHeight: 8,
                                dotWidth: 20,
                                spacing: 16,
                              ),
                            ),
                          ),

                    const SizedBox(height: 40),

                    /// task name
                    MyTextField(
                      prefixIcon: Icons.task,
                      textFieldController: adminTaskProvider.taskNameController,
                      textFieldName: "Task Name",
                      hintText: "Create task name",
                      simpleTextTextFieldName: "Task Name*",
                    ),

                    /// task assigned to the person
                    MyTextField(
                      prefixIcon: Icons.person,
                      textFieldController:
                          adminTaskProvider.taskAssignedPersonController,
                      textFieldName: "Task Assigned Person",
                      hintText: "Task assigned",
                      simpleTextTextFieldName: "Task Assigned Person*",
                    ),

                    /// Task given by the person
                    MyTextField(
                      prefixIcon: Icons.person,
                      textFieldController:
                          adminTaskProvider.taskGivenPersonController,
                      textFieldName: "Task Given Person",
                      hintText: "Task given person",
                      simpleTextTextFieldName: "Task Given Person*",
                    ),

                    /// Start Date Text field
                    MyTextField(
                      onTap: () {
                        adminTaskProvider.selectDate(
                          context,
                          adminTaskProvider.startDateTimeController,
                        );
                      },
                      isReadOnly: true,
                      prefixIcon: Icons.date_range,
                      textFieldController:
                          adminTaskProvider.startDateTimeController,
                      textFieldName: "Task Started Date",
                      hintText: "Task started date",
                      simpleTextTextFieldName: "Task Started Date*",
                    ),

                    /// End Date Text field
                    MyTextField(
                      onTap: () {
                        adminTaskProvider.selectDate(
                          context,
                          adminTaskProvider.dueDateTimeController,
                        );
                      },
                      isReadOnly: true,
                      prefixIcon: Icons.date_range,
                      textFieldController:
                          adminTaskProvider.dueDateTimeController,
                      textFieldName: "Task Due Date",
                      hintText: "Task due date",
                      simpleTextTextFieldName: "Task Due Date*",
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    /// add task btn to user
                    MyBtn(
                      btnColor: AppColors.primaryColor,
                      btnTitle: "Add Task To User",
                      btnOnTap: () {
                        adminTaskProvider.addTaskToEmployees(context);
                      },
                      imgUrl: "assets/images/svg/create-task-icon.svg",
                      iconHeight: 26,
                      iconWidth: 26,
                      btnBorderRadius: 4,
                      btnHeight: 50,
                      btnWidth: double.infinity,
                      marginLeft: 0,
                      marginRight: 0,
                    ),

                    const SizedBox(
                      height: 30,
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
