import 'package:empprojectdemo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmployeeAboutAppScreen extends StatelessWidget {
  const EmployeeAboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: SingleChildScrollView(
          child: Container(
            margin:
                const EdgeInsets.only(top: 30, bottom: 30, right: 20, left: 20),
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.start,
                  '''
You're working on a Flutter application designed to facilitate communication and task management between employees and admins. This app not only enables seamless communication but also allows admins to assign tasks and track their progress. Employees can view, accept, and update the status of their assigned tasks, ensuring clarity and accountability in task management.

The application also includes a robust attendance management feature, where admins can view and monitor employee attendance records. This feature might integrate with Google Sheets or Firebase, allowing real-time updates and easy access to attendance data. The attendance tracking could involve daily logs where employees mark their presence or absence, and this data is instantly available to the admin for review.

To streamline the user experience, the app could include role-based navigation, ensuring that admins and employees have access to the specific features they need. For example, admins might have dashboards showing overall task progress, attendance summaries, and the ability to communicate with all employees, while employees might focus on their task lists and attendance records.

In terms of communication, the app could feature real-time messaging or chat functionality, enabling instant communication between employees and admins. This would be crucial for quick task updates, clarifications, or general communication within the organization.

The app could also include additional features like push notifications to remind employees of deadlines or alert admins when attendance data is missing. Overall, this Flutter application aims to enhance productivity, streamline task management, and improve communication within an organization, ensuring both employees and admins can perform their roles effectively.
''',
                  style: GoogleFonts.montserrat(
                    color: AppColors.subTitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Ideology by ",
                      style: GoogleFonts.montserrat(
                        color: AppColors.subTitleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Naveen",
                      style: GoogleFonts.montserrat(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  children: [
                    Text(
                      "UUI/UX and Developed by ",
                      style: GoogleFonts.montserrat(
                        color: AppColors.subTitleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Imran B",
                      style: GoogleFonts.montserrat(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
