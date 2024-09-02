import 'package:cached_network_image/cached_network_image.dart';
import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/modals/event_data_model.dart';
import 'package:empprojectdemo/provider/admin_provider/event_provider.dart';
import 'package:empprojectdemo/widgets/myTaskDetailsContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EventsDetailsScreen extends StatelessWidget {
  final EventData eventData;

  const EventsDetailsScreen({
    super.key,
    required this.eventData,
  });

  @override
  Widget build(BuildContext context) {
    /// media query for the screen size
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Scaffold(
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
      body: Consumer<EventProvider>(
        builder: (
          context,
          eventProvider,
          child,
        ) {
          return SingleChildScrollView(
            child: Column(
              children: [
                /// task images
                eventData.eventImages.length == 1
                    ? CachedNetworkImage(
                        imageUrl: eventData.eventImages[0],
                        placeholder: (context, url) {
                          return Container(
                            height: screenHeight * 0.4,
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
                            height: screenHeight * 0.4,
                            width: screenWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.zero,
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
                            height: screenHeight * 0.4,
                            width: screenWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.zero,
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
                              controller: eventProvider
                                  .eventTaskDetailScreenPageController,
                              itemCount: eventData.eventImages.length,
                              itemBuilder: (context, index) {
                                return CachedNetworkImage(
                                  imageUrl: eventData.eventImages[index],
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
                                        borderRadius: BorderRadius.zero,
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
                            controller: eventProvider
                                .eventTaskDetailScreenPageController,
                            count: eventData.eventImages.length,
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
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// task name text
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
                        taskValue: eventData.eventName,
                      ),

                      const SizedBox(height: 20),

                      /// task given person text
                      Text(
                        "Event organizer",
                        style: GoogleFonts.montserrat(
                          color: AppColors.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),

                      /// task given person detail
                      MyTaskDetailsContainer(
                        taskValue: eventData.eventOrganizer,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      /// task start date text
                      Text(
                        "Task duration",
                        style: GoogleFonts.montserrat(
                          color: AppColors.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),

                      /// task duration
                      MyTaskDetailsContainer(
                        taskValue: eventData.eventDuration,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      /// task due date text
                      Text(
                        "Event date",
                        style: GoogleFonts.montserrat(
                          color: AppColors.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),

                      /// event  date detail
                      MyTaskDetailsContainer(
                        taskValue: eventData.eventDate,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
