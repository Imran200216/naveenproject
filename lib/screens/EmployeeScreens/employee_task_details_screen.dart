import 'package:cached_network_image/cached_network_image.dart';
import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/modals/AdminTaskSchedultModel.dart';
import 'package:empprojectdemo/provider/admin_provider/admin_task_provider.dart';
import 'package:empprojectdemo/widgets/myTaskDetailsContainer.dart';
import 'package:empprojectdemo/widgets/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EmployeeTaskDetailsScreen extends StatelessWidget {
  final AdminTaskScheduleModel task;

  const EmployeeTaskDetailsScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    /// media query for the screen size
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.whiteColor,
              size: 16,
            ),
          ),
          title: const Text("About app"),
          titleTextStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            color: AppColors.whiteColor,
            fontSize: 16,
          ),
        ),
        body: Consumer<AdminTaskProvider>(
          builder: (
            context,
            adminTaskProvider,
            child,
          ) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  /// task images
                  task.taskImages.length == 1
                      ? CachedNetworkImage(
                          imageUrl: task.taskImages[0],
                          placeholder: (context, url) {
                            return Container(
                              height: screenHeight * 0.6,
                              width: screenWidth,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.zero,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/images/svg/image-icon.svg",
                                  height: 64,
                                  width: 64,
                                  fit: BoxFit.cover,
                                  color: AppColors.subTitleColor,
                                ),
                              ),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return Container(
                              height: screenHeight * 0.6,
                              width: screenWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(screenWidth * 0.125),
                                  bottomRight:
                                      Radius.circular(screenWidth * 0.125),
                                ),
                                color: AppColors.cachedBgColor,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/images/svg/image-error-icon.svg",
                                  height: 64,
                                  width: 64,
                                  fit: BoxFit.cover,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            );
                          },
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              height: screenHeight * 0.6,
                              width: screenWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(screenWidth * 0.125),
                                  bottomRight:
                                      Radius.circular(screenWidth * 0.125),
                                ),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.6,
                              child: PageView.builder(
                                controller: adminTaskProvider
                                    .employeeTaskDetailScreenPageController,
                                itemCount: task.taskImages.length,
                                itemBuilder: (context, index) {
                                  return CachedNetworkImage(
                                    imageUrl: task.taskImages[index],
                                    placeholder: (context, url) {
                                      return Center(
                                        child: SvgPicture.asset(
                                          "assets/images/svg/image-icon.svg",
                                          height: 64,
                                          width: 64,
                                          fit: BoxFit.cover,
                                          color: AppColors.subTitleColor,
                                        ),
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return Center(
                                        child: SvgPicture.asset(
                                          "assets/images/svg/image-error-icon.svg",
                                          height: 64,
                                          width: 64,
                                          fit: BoxFit.cover,
                                          color: AppColors.blackColor,
                                        ),
                                      );
                                    },
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(
                                                screenWidth * 0.125),
                                            bottomRight: Radius.circular(
                                                screenWidth * 0.125),
                                          ),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            SmoothPageIndicator(
                              controller: adminTaskProvider
                                  .employeeTaskDetailScreenPageController,
                              count: task.taskImages.length,
                              effect: ExpandingDotsEffect(
                                activeDotColor: AppColors.primaryColor,
                                dotHeight: 8,
                                dotWidth: 8,
                                expansionFactor: 4,
                              ),
                            ),
                          ],
                        ),

                  const SizedBox(
                    height: 30,
                  ),

                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// task name
                        Text(
                          "Task Name",
                          style: GoogleFonts.montserrat(
                            color: AppColors.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),

                        /// task name
                        MyTaskDetailsContainer(
                          taskValue: task.taskName,
                        ),

                        const SizedBox(height: 20),

                        /// task assigned person
                        Text(
                          "Task assigned person",
                          style: GoogleFonts.montserrat(
                            color: AppColors.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),

                        /// task assigned person details
                        MyTaskDetailsContainer(
                          taskValue: task.taskAssignedPerson,
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
