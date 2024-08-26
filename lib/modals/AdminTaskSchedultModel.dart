import 'package:cloud_firestore/cloud_firestore.dart';

class AdminTaskScheduleModel {
  String taskName;
  String taskAssignedPerson;
  String taskGivenPerson;
  Timestamp taskStartedDate;
  Timestamp taskDueDate;
  List<String> taskImages;

  AdminTaskScheduleModel({
    required this.taskName,
    required this.taskAssignedPerson,
    required this.taskGivenPerson,
    required this.taskStartedDate,
    required this.taskDueDate,
    required this.taskImages,
  });

  /// Convert a Task object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'taskAssignedPerson': taskAssignedPerson,
      'taskGivenPerson': taskGivenPerson,
      'taskStartedDate': taskStartedDate,
      'taskDueDate': taskDueDate,
      'taskImages': taskImages,
    };
  }

  /// Create a Task object from a Map object
  factory AdminTaskScheduleModel.fromMap(Map<String, dynamic> map) {
    return AdminTaskScheduleModel(
      taskName: map['taskName'],
      taskAssignedPerson: map['taskAssignedPerson'],
      taskGivenPerson: map['taskGivenPerson'],
      taskStartedDate: map['taskStartedDate'],
      taskDueDate: map['taskDueDate'],
      taskImages: List<String>.from(map['taskImages']),
    );
  }
}
