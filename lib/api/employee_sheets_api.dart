import 'package:empprojectdemo/modals/EmployeeAttendanceModel.dart';

import 'package:gsheets/gsheets.dart';

class UserSheetsApi {
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "emsproject-96c89",
  "private_key_id": "baa9e08aa761ec4760d5ff62f3e5a93be7f5de48",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQDBMhtINyaKxLkM\nazsx8BmDK3OFc6xltSqmSAw2/dl1BgCstNjLWi3IBe4dDdOr+2fSFo33lqGbiwHT\nzQ6QHg0FVcoeRFTMGaVVPnnZX3DDkTic2iWNbXXB0k/dEirDCvp4SABzLcEwC5NZ\n9aCT632H9Zeam92JtJZn8vJh2HrlsM9xlN4iv2nW75cxcQHmPMITYySsvcGG/7Gz\n5WXAdajbDqfAK/ADJl+W5bbTFFcNJy30+uiIkIZruyw0EqajA4fvXJQWgAmuuIyl\nVmsr0aqA8HqDanUEIdldMzCJ4WVgIbe/6fcm1rc0h07iRYH768SRoEFHiAd4d9Qh\nnh5WfAHpAgMBAAECgf8+Wr8othz9iQ0sq7sxXl4Ab1MUnjth6jyIUPEEq+bSC+1J\ngu46huY4qWeX32xocW3bGLEaw+kuzkv7YKv5Adq+SyHEi4PCj2vgU2b/enruVi+u\neJM0keCx+D4daWgbIgkOX9S7GpY4DuSkhBfuBE59Q+1vnqaX5pc2RIbpO8L16SO1\nBU4Cy+VFBBvvQ1f3ymonkGSBEYywXL7vihAm8TCG+v0gf9JBind+t3tdYvGRffHo\n3un4mznzcyEh59XB5/IEh6yiZztwsJ2J0dqDhP44VUn8Vgw1QZFgeqE+Kh3z5gEI\noJUms0wi9PoGEeqEWA+ExTYt/9mHD3GAcsNxvCUCgYEA4gcxb6RM85+UtKwoJGNW\nYkHDGQ13mGafIfTeQaLSZqu66Qgv9nNvIlu1Q5c3AZ/XQ4mSmZIOaJV+o7yGM+TJ\ng3MrSU+xf+ypgNdkn6gvgjgClAj5h3GveUMwssFTiZO1lsPQuReZmF0bV/01nefo\nRoPsYke2kbtu0ZZKTf1uh2UCgYEA2tBgp/GVFjfmxVOObwd04CWEy6EXoZcHszDW\nU/lPNxBU8NhLB7wwKc4mN4Gf6WfGDlenURH1UBflMm7Tqt5b53YKk1svfpZZAo7v\nHLDyINArXG8fZSdLuj2LXzW5gHHGKCXF2P3cQnmo8pYMGv7jpKZzr5bIWk8oMclv\n2x2jcjUCgYEA2VclWD7ap+CpM1nfd631oKGvomVqvKbhGdvF48NXIda78dwnkonJ\nMXaRxB6hi/RRH+Yni3gAVtx5W6SqPzgd9UJHO0VgXqwJCZUUctlcZZDKGeLPXkgY\n/Td4mkp/s2jPUduU1oY08WeGJYObjO00UqoEITTn/xYGJ46mgHvTTmkCgYBO88cc\ncgfIR41l/9sx5q/ePMtoqgybyqIFnwaGsDtL9AGiEXkpJlb+jpqthoELt9z3ydre\nXqt0JdsWUnTff3IL10TDnLBLbbZaPPa8FICZJGOw64uZdQ9W+OP0C6+OT/8e91on\nDJpQBhPWzBs8FmJPQ5wUbESIiW1IYZWRq2URTQKBgAJBXRA1hvf4FWlAL9OXznQm\nA6PR+19iaXHc8BU7wyvapR8DaHII6HT9rjGz4izW7j1gspuZi0c89xrHE1naAe0g\nVLfcebBxQoG8tmQqZQ0uNRfyJF+TlJLQ/dbm8wIuOePbYLSvUMbA7lHlqar+suC0\nEx/TN8bBNItmod0d6rYq\n-----END PRIVATE KEY-----\n",
  "client_email": "naveenproject@emsproject-96c89.iam.gserviceaccount.com",
  "client_id": "116347121055546831786",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/naveenproject%40emsproject-96c89.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

  static const _spreadsheetId = "1VA2-ywQdC-nkyhhiDjXdmBhToQkOtLj5ttR1T-Szta8";

  static final _gSheets = GSheets(_credentials);

  static Worksheet? _userSheet;

  static Future init() async {
    final spreadSheet = await _gSheets.spreadsheet(_spreadsheetId);
    _userSheet = await _getWorkSheet(spreadSheet, title: "Employee Attendance");

    final fistRow = EmployeeAttendanceFields.getFields();
    _userSheet!.values.insertRow(1, fistRow);
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadSheet, {
    required String title,
  }) async {
    try {
      return await spreadSheet.addWorksheet(title);
    } catch (e) {
      return spreadSheet.worksheetByTitle(title)!;
    }
  }

  /// inserting the data to the excel sheet
  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet == null) return;

    for (var row in rowList) {
      await _userSheet!.values.map.appendRow(row);
    }
  }
}
