import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserTypeProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateUserType(String userId, String personType) async {
    try {
      // Update Fire store
      await _firestore
          .collection('user')
          .doc(userId)
          .update({'personType': personType});

      // Save personType in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('personType', personType);

      notifyListeners();
    } catch (e) {
      // Handle error, e.g., show a toast message
      print("Failed to update user type: $e");
    }
  }
}
