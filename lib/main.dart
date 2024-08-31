import 'package:empprojectdemo/api/employee_sheets_api.dart';
import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/firebase_options.dart';
import 'package:empprojectdemo/provider/admin_provider/admin_task_provider.dart';
import 'package:empprojectdemo/provider/authentication_provider/email_auth_provider.dart';
import 'package:empprojectdemo/provider/authentication_provider/google_auth_provider.dart';
import 'package:empprojectdemo/provider/bottomnav_provider.dart';

import 'package:empprojectdemo/provider/employee_provider/employee_attendance_provider.dart';
import 'package:empprojectdemo/provider/employee_provider/employee_task_provider.dart';
import 'package:empprojectdemo/provider/internet_checker_provider.dart';
import 'package:empprojectdemo/provider/password_visibility_provider.dart';
import 'package:empprojectdemo/provider/share_plus_provider.dart';
import 'package:empprojectdemo/provider/user_image_provider.dart';

import 'package:empprojectdemo/provider/user_type_provider.dart';
import 'package:empprojectdemo/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// status bar color
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColors.blackColor,
      statusBarBrightness: Brightness.dark,
    ),
  );

  /// to access the excel documents
  await UserSheetsApi.init();

  /// to access the fire base
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// google auth provider
        ChangeNotifierProvider(
          create: (_) => GoogleAuthenticationProvider(),
        ),

        /// email auth provider
        ChangeNotifierProvider(
          create: (_) => EmailAuthenticationProvider(),
        ),

        /// bottom nav provider
        ChangeNotifierProvider(
          create: (_) => BottomNavProvider(),
        ),

        /// admin task provider
        ChangeNotifierProvider(
          create: (_) => AdminTaskProvider(),
        ),

        /// user type provider
        ChangeNotifierProvider(
          create: (_) => UserTypeProvider(),
        ),

        /// internet checker provider
        ChangeNotifierProvider(
          create: (_) => InternetCheckerProvider(),
        ),

        /// Employee task provider
        ChangeNotifierProvider(
          create: (_) => EmployeeTaskProvider(),
        ),

        /// Employee excel provider
        ChangeNotifierProvider(
          create: (_) => EmployeeAttendanceProvider(),
        ),

        /// share plus provider
        ChangeNotifierProvider(
          create: (_) => ShareProvider(),
        ),

        /// password visibility provider
        ChangeNotifierProvider(
          create: (_) => PasswordVisibilityProvider(),
        ),

        /// user image email provider
        ChangeNotifierProvider(
          create: (_) => UserImageProvider(),
        ),
      ],
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: SplashScreen(),
        );
      },
    );
  }
}
