import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/provider/admin_provider/event_provider.dart';
import 'package:empprojectdemo/provider/internet_checker_provider.dart';
import 'package:empprojectdemo/widgets/myDropdownTextField.dart';
import 'package:empprojectdemo/widgets/mybtn.dart';
import 'package:empprojectdemo/widgets/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CreationEventTaskScreen extends StatelessWidget {
  const CreationEventTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.whiteColor,
              size: 20,
            ),
          ),
          title: const Text("Creation of Events"),
          titleTextStyle: GoogleFonts.montserrat(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        body: Consumer2<EventProvider, InternetCheckerProvider>(
          builder: (
            context,
            eventProvider,
            internetCheckerProvider,
            child,
          ) {
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 30,
                  bottom: 30,
                ),
                child: Column(
                  children: [
                    /// add the image to the task
                    InkWell(
                      onTap: () async {
                        // Pick image functionality
                        await eventProvider.pickImages(context);

                        if (eventProvider.pageViewItems.isNotEmpty) {
                          eventProvider.pageController.jumpToPage(1);
                        }
                      },
                      child: SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: PageView.builder(
                          controller: eventProvider.pageController,
                          itemCount: eventProvider.pageViewItems.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return eventProvider.pageViewItems[index];
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    eventProvider.selectedImages.isEmpty
                        ? const SizedBox()
                        : Center(
                            child: SmoothPageIndicator(
                              controller: eventProvider.pageController,
                              count: eventProvider.pageViewItems.length,
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

                    /// event name
                    MyTextField(
                      prefixIcon: Icons.task,
                      textFieldController: eventProvider.eventNameController,
                      textFieldName: "Event Name",
                      hintText: "Event  name",
                      simpleTextTextFieldName: "Event Name*",
                    ),

                    /// event organized person
                    MyTextField(
                      prefixIcon: Icons.person,
                      textFieldController:
                          eventProvider.eventOrganizerController,
                      textFieldName: "Event Organizer",
                      hintText: "Event Organizer",
                      simpleTextTextFieldName: "Event Organizer*",
                    ),

                    /// event date controller
                    MyTextField(
                      isReadOnly: true,
                      onTap: () {
                        /// date functionality
                        eventProvider.selectDate(
                            context, eventProvider.eventDateController);
                      },
                      prefixIcon: Icons.date_range,
                      textFieldController: eventProvider.eventDateController,
                      textFieldName: "Event Date",
                      hintText: "Event Date",
                      simpleTextTextFieldName: "Event Date*",
                    ),

                    /// event start time controller
                    MyTextField(
                      isReadOnly: true,
                      onTap: () {
                        /// time functionality
                        eventProvider.selectTime(
                            context, eventProvider.eventDurationTimeController);
                      },
                      prefixIcon: Icons.timelapse,
                      textFieldController:
                          eventProvider.eventDurationTimeController,
                      textFieldName: "Event Duration",
                      hintText: "Event Duration",
                      simpleTextTextFieldName: "Event Duration*",
                    ),

                    /// event volunteer

                    MyDropDownTextField(
                      items: eventProvider.listVolunteerStatus,
                      onChanged: (newValue) {
                        eventProvider.selectVolunteerStatus = newValue;
                      },
                      textFieldHint: "Select options",
                      prefixIcon: Icons.school,
                      simpleTextTextFieldName: "Event volunteer",
                    ),

                    const SizedBox(
                      height: 60,
                    ),

                    /// add task btn to user
                    MyBtn(
                      btnColor: AppColors.primaryColor,
                      btnTitle: "Add events to employees",
                      btnOnTap: () {
                        /// add events functionality to the employee home screen
                        eventProvider.addEvent(context);
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
