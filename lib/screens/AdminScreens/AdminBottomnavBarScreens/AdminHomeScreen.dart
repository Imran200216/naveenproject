import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/modals/AdminTaskSchedultModel.dart';
import 'package:empprojectdemo/provider/admin_provider/admin_task_provider.dart';
import 'package:empprojectdemo/provider/internet_checker_provider.dart';
import 'package:empprojectdemo/screens/AdminScreens/admin_task_details_screen.dart';
import 'package:empprojectdemo/screens/AdminScreens/creation_event_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AdminTaskProvider, InternetCheckerProvider>(
      builder: (
        context,
        adminTaskProvider,
        internetCheckerProvider,
        child,
      ) {
        if (!internetCheckerProvider.isNetworkConnected) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/images/lottie/no-internet-connection-animation.json",
                  height: 240,
                  width: 240,
                  fit: BoxFit.cover,
                ),
                Text(
                  "No Internet Connection",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.subTitleColor,
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              /// Creation of event task screen and displayed it in the employee home screen
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const CreationEventTaskScreen();
              }));
            },
            backgroundColor: AppColors.primaryColor,
            child: SvgPicture.asset(
              "assets/images/svg/task-icon.svg",
              height: 30,
              width: 30,
              fit: BoxFit.cover,
              color: AppColors.whiteColor,
            ),
          ),
          body: FutureBuilder<List<AdminTaskScheduleModel>>(
            future: adminTaskProvider.fetchTasks(),
            builder: (
              context,
              snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading indicator while tasks are being fetched
                return Center(
                  child: LoadingAnimationWidget.stretchedDots(
                    color: AppColors.primaryColor,
                    size: 60,
                  ),
                );
              } else if (snapshot.hasError) {
                // Handle error state
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: GoogleFonts.montserrat(
                      color: AppColors.subTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                // Handle empty state
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/svg/no-task-icon.svg",
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        'No tasks available',
                        style: GoogleFonts.montserrat(
                          color: AppColors.subTitleColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                // Display the list of tasks
                List<AdminTaskScheduleModel> tasks = snapshot.data!;
                return SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 30, bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Task
                        Text(
                          "Scheduled Task",
                          style: GoogleFonts.montserrat(
                            color: AppColors.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// list view of the task for employee
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            final task = tasks[index];
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return AdminTaskDetailsScreen(task: task);
                                    }));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.taskTileBgColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(8.0),

                                      // Background color of the tile
                                      leading: SvgPicture.asset(
                                        "assets/images/svg/task-icon.svg",
                                        height: 60,
                                        width: 60,
                                        color: AppColors.primaryColor,
                                        fit: BoxFit.cover,
                                      ),
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4.0),
                                        // Spacing between title and subtitle
                                        child: Text(
                                          task.taskName,
                                          style: GoogleFonts.montserrat(
                                            color: AppColors.primaryColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      subtitle: Text(
                                        'Assigned to: ${task.taskAssignedPerson}\n'
                                        'Due: ${DateFormat('dd MMM yyyy').format(task.taskDueDate.toDate())}',
                                        style: GoogleFonts.montserrat(
                                          color: AppColors.subTitleColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
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
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
