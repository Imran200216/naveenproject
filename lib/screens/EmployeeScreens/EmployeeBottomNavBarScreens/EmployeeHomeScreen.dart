import 'package:cached_network_image/cached_network_image.dart';
import 'package:empprojectdemo/screens/EmployeeScreens/events_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/modals/event_data_model.dart';
import 'package:empprojectdemo/provider/admin_provider/admin_task_provider.dart';
import 'package:empprojectdemo/provider/admin_provider/event_provider.dart';
import 'package:empprojectdemo/provider/internet_checker_provider.dart';

class EmployeeHomeScreen extends StatelessWidget {
  const EmployeeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<AdminTaskProvider, InternetCheckerProvider, EventProvider>(
      builder: (
        context,
        adminTaskProvider,
        internetCheckerProvider,
        eventProvider,
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
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(
                left: 20,
                top: 30,
                bottom: 30,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "UpComing Events",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  eventProvider.events.isEmpty
                      ? Center(
                          child: Text(
                            "No upcoming events",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: AppColors.subTitleColor,
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          // Added to make it scroll smoothly within SingleChildScrollView
                          physics: const NeverScrollableScrollPhysics(),
                          // Prevent the ListView from scrolling independently
                          itemCount: eventProvider.events.length,
                          itemBuilder: (context, index) {
                            EventData event = eventProvider.events[index];
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: AppColors.subTitleColor,
                                  width: 1,
                                ),
                              ),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return EventsDetailsScreen(
                                      eventData: event,
                                    );
                                  }));
                                },
                                title: Text(
                                  event.eventName,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                                subtitle: Text(
                                  event.eventDate,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: AppColors.subTitleColor,
                                  ),
                                ),
                                trailing: event.eventImages.isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl: event.eventImages.first,
                                        width: 100,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            LoadingAnimationWidget.dotsTriangle(
                                          color: AppColors.primaryColor,
                                          size: 20,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      )
                                    : null,
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
