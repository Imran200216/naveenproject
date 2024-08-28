import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empprojectdemo/modals/AdminTaskSchedultModel.dart';
import 'package:flutter/cupertino.dart';

class EmployeeTaskProvider extends ChangeNotifier {
  final CollectionReference _tasksCollection =
      FirebaseFirestore.instance.collection('adminTaskScheduleToEmployee');

  Future<List<AdminTaskScheduleModel>> fetchTasks() async {
    try {
      final querySnapshot = await _tasksCollection.get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        // Explicitly cast taskImages to List<String>
        List<String> taskImages = [];
        if (data['taskImages'] != null) {
          taskImages = List<String>.from(data['taskImages'] as List<dynamic>);
        }

        return AdminTaskScheduleModel(
          taskName: data['taskName'] ?? '',
          taskAssignedPerson: data['taskAssignedPerson'] ?? '',
          taskGivenPerson: data['taskGivenPerson'] ?? '',
          taskStartedDate: data['taskStartedDate'] ?? Timestamp.now(),
          taskDueDate: data['taskDueDate'] ?? Timestamp.now(),
          taskImages: taskImages,
        );
      }).toList();
    } catch (e) {
      print('Failed to fetch tasks: $e');
      return [];
    }
  }
}
