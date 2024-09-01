import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empprojectdemo/provider/authentication_provider/email_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoreDetailsEmployeeFieldsProvider extends ChangeNotifier {
  /// More details employee controllers
  final TextEditingController ageEmployeeController = TextEditingController();
  final TextEditingController addressEmployeeController =
      TextEditingController();
  final TextEditingController designationEmployeeController =
      TextEditingController();
  final TextEditingController workExperienceEmployeeController =
      TextEditingController();

  /// Boolean to track update status
  bool _isUpdated = false;

  bool get isUpdated => _isUpdated;

  /// Function to update employee details in Firestore
  Future<void> updateEmployeeDetails(String uid) async {
    try {
      // Prepare the data to update
      Map<String, dynamic> data = {
        'age': ageEmployeeController.text.trim(),
        'address': addressEmployeeController.text.trim(),
        'designation': designationEmployeeController.text.trim(),
        'workExperience': workExperienceEmployeeController.text.trim(),
      };

      // Update Firestore document in userByEmailAuth collection
      await FirebaseFirestore.instance
          .collection('userByEmailAuth')
          .doc(uid)
          .update(data);

      // Set update status to true and notify listeners
      _isUpdated = true;
      notifyListeners();
    } catch (e) {
      // Handle error
      print("Error updating employee details: $e");
      _isUpdated = false; // Ensure the status reflects the failure
      notifyListeners();
    }
  }

  /// fetching the user Details
  Map<String, dynamic>? userDetails;
  bool isUpdatedFetched = false;

  Future<void> fetchEmployeeDetails(String userId) async {
    try {
      // Simulating a fetch request (replace with your Firestore query)
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('userByEmailAuth')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        userDetails = snapshot.data() as Map<String, dynamic>;
        isUpdatedFetched = true;
        print("Data fetched: $userDetails"); // Debugging output
      } else {
        print("No such document!");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
    notifyListeners();
  }

  Future<void> fetchEmployeeDetailsForCurrentUser(BuildContext context) async {
    final userId =
        Provider.of<EmailAuthenticationProvider>(context, listen: false)
            .emailUser
            ?.uid;
    if (userId != null) {
      await fetchEmployeeDetails(userId);
    }
    notifyListeners();
  }
}
