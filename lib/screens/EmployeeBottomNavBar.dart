import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/provider/bottomnav_provider.dart';
import 'package:empprojectdemo/screens/EmployeeBottomNavBarScreens/EmployeeAttendanceScreen.dart';
import 'package:empprojectdemo/screens/EmployeeBottomNavBarScreens/EmployeeHomeScreen.dart';
import 'package:empprojectdemo/screens/EmployeeBottomNavBarScreens/EmployeeProfileScreen.dart';
import 'package:empprojectdemo/screens/EmployeeBottomNavBarScreens/EmployeeTaskScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmployeeBottomNavBar extends StatelessWidget {
  EmployeeBottomNavBar({super.key});

  /// Bottom navigation bar screens
  final List<Widget> widgetList = [
    /// Chat screen
    const EmployeeHomeScreen(),

    /// Archive screen
    const EmployeeTaskScreen(),

    /// Notes screen
    const EmployeeAttendanceScreen(),

    /// Profile Screen
    const EmployeeProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, bottomNavProvider, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.whiteColor,

            /// Bottom navigation bar
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                bottomNavProvider.setIndex(index);
              },
              currentIndex: bottomNavProvider.currentIndex,
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: AppColors.subTitleColor,
              unselectedLabelStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                color: AppColors.subTitleColor,
              ),
              selectedLabelStyle: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/svg/home-icon.svg',
                    color: bottomNavProvider.currentIndex == 0
                        ? AppColors.primaryColor
                        : AppColors.subTitleColor,
                    height: 24,
                    width: 24,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/svg/task-icon.svg',
                    color: bottomNavProvider.currentIndex == 1
                        ? AppColors.primaryColor
                        : AppColors.subTitleColor,
                    height: 24,
                    width: 24,
                  ),
                  label: 'Task',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/svg/attendance-icon.svg',
                    color: bottomNavProvider.currentIndex == 2
                        ? AppColors.primaryColor
                        : AppColors.subTitleColor,
                    height: 24,
                    width: 24,
                  ),
                  label: 'Attendance',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/svg/profile-icon.svg',
                    color: bottomNavProvider.currentIndex == 3
                        ? AppColors.primaryColor
                        : AppColors.subTitleColor,
                    height: 24,
                    width: 24,
                  ),
                  label: 'Profile',
                ),
              ],
            ),

            body: IndexedStack(
              index: bottomNavProvider.currentIndex,
              children: widgetList,
            ),
          ),
        );
      },
    );
  }
}
