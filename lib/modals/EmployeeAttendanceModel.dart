class EmployeeAttendanceFields {
  static const String name = 'name';
  static const String email = 'email';
  static const String attendance = 'attendance';

  static List<String> getFields() {
    return [name, email, attendance];
  }
}

class Employee {
  final String name;
  final String email;
  final bool isPresentOrAbsent;

  Employee({
    required this.name,
    required this.email,
    required this.isPresentOrAbsent,
  });

  Map<String, dynamic> toJson() => {
        EmployeeAttendanceFields.name: name,
        EmployeeAttendanceFields.email: email,
        EmployeeAttendanceFields.attendance: isPresentOrAbsent,
      };
}
