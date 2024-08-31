import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserImageProvider extends ChangeNotifier {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  File? get image => _image;

  Future<void> pickImageFromCamera(String uid) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      await _uploadImageToFirestore(uid);
      notifyListeners();
    }
  }

  Future<void> pickImageFromGallery(String uid) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      await _uploadImageToFirestore(uid);
      notifyListeners();
    }
  }

  Future<void> _uploadImageToFirestore(String uid) async {
    if (_image == null) return;

    // Upload image to Firebase Storage
    final storageRef = FirebaseStorage.instance.ref().child('userImages/$uid');
    final uploadTask = storageRef.putFile(_image!);
    final snapshot = await uploadTask.whenComplete(() {});

    // Get the image URL
    final imageUrl = await snapshot.ref.getDownloadURL();

    // Update Fire store with the image URL
    await FirebaseFirestore.instance
        .collection('userByEmailAuth')
        .doc(uid)
        .update({'imageUrl': imageUrl});
  }
}
