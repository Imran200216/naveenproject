class EmployeeAttendanceFields {
  static const String name = 'name';
  static const String email = 'email';
  static const String attendance = 'attendance';
  static const String currentDate = 'currentDate';

  static List<String> getFields() {
    return [name, email, attendance, currentDate];
  }
}

class Employee {
  final String name;
  final String email;
  final String currentDate;
  final String attendanceStatus;

  Employee({
    required this.name,
    required this.email,
    required this.attendanceStatus,
    required this.currentDate,
  });

  Map<String, dynamic> toJson() => {
    EmployeeAttendanceFields.name: name,
    EmployeeAttendanceFields.email: email,
    EmployeeAttendanceFields.attendance: attendanceStatus,
    EmployeeAttendanceFields.currentDate: currentDate,
  };

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json[EmployeeAttendanceFields.name] as String,
      email: json[EmployeeAttendanceFields.email] as String,
      attendanceStatus: json[EmployeeAttendanceFields.attendance] as String,
      currentDate: json[EmployeeAttendanceFields.currentDate] as String,
    );
  }
}

