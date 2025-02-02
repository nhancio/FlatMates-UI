import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterUserController extends GetxController {
  // Controllers for TextFields
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  // Observables for selected values
  var selectedGender = RxnString();
  var selectedProfession = RxnString();
  var profileImage = Rxn<File>();

  // Image picker
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }

  Future<void> addUserToFirestore({
    required String userName,
    required String userEmail,
    required String userPhoneNumber,
    required String? profession,
    required String? gender,
    required String? ageText,
    required File? profileImage,
  }) async {
    try {
      // Get the current authenticated user
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        throw Exception('No authenticated user found.');
      }

      String uid = currentUser.uid; // Firebase Auth UID
      int? age;
      String? imageUrl;

      // Parse age if provided
      if (ageText != null && ageText.trim().isNotEmpty) {
        age = int.tryParse(ageText); // Convert age to int
      }

      // Upload profile image if provided
      // if (profileImage != null) {
      //   imageUrl = await uploadProfileImage(profileImage);
      // }

      // Create or update the document in Firestore with the UID as the document ID
      await usersCollection.doc(uid).set({
        'userName': userName,
        'userEmail': userEmail,
        'userPhoneNumber': userPhoneNumber,
        'profession': profession,
        'gender': gender,
        'age': age,
        'profileUrl': imageUrl, // URL of the user's profile picture
        'createdAt': FieldValue.serverTimestamp(), // Add timestamp
      });

      print('User added successfully with UID: $uid');
    } catch (e) {
      print('Failed to add user: $e');
      rethrow;
    }
  }

  // Validation logic
/*
  bool validateForm() {
    // Check if required fields are empty or invalid
    if (nameController.text.isEmpty ||
        selectedGender.value == null ||
        selectedProfession.value == null ||
        ageController.text.isEmpty ||
        phoneController.text.length != 10) {  // Check if phone number is 10 digits
      Get.snackbar(
        'Error',
        'Please fill all required fields. Ensure the phone number has exactly 10 digits',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white70,
        colorText: Colors.black,
      );
      return false;
    }
    return true;
  }
*/
  bool validateForm() {
    String errorMessage = '';

    if (nameController.text.isEmpty) {
      errorMessage = 'Name is required.';
    } else if (selectedGender.value == null) {
      errorMessage = 'Please select a gender.';
    } else if (selectedProfession.value == null) {
      errorMessage = 'Please select a profession.';
    } else if (ageController.text.isEmpty) {
      errorMessage = 'Age is required.';
    } else if (int.tryParse(ageController.text) == null || int.parse(ageController.text) <= 0) {
      errorMessage = 'Please enter a valid age.';
    } else if (phoneController.text.isEmpty) {
      errorMessage = 'Phone number is required.';
    } else if (phoneController.text.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(phoneController.text)) {
      errorMessage = 'Phone number must be exactly 10 digits and contain only numbers.';
    }

    if (errorMessage.isNotEmpty) {
      Get.snackbar(
        'Error',
        errorMessage,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.grey.shade100,
        colorText: Colors.black,
        duration: Duration(seconds: 2),
      );
      return false;
    }

    return true;
  }


  // Future<String> uploadProfileImage(File image) async {
  //   try {
  //     // Reference to Firebase Storage
  //     final storageRef = FirebaseStorage.instance
  //         .ref()
  //         .child('profileImages/${DateTime.now().millisecondsSinceEpoch}.jpg');

  //     // Upload the file to the specified path
  //     await storageRef.putFile(image);

  //     // Get the image's download URL
  //     final imageUrl = await storageRef.getDownloadURL();
  //     return imageUrl;
  //   } catch (e) {
  //     print('Error uploading image: $e');
  //     throw 'Failed to upload image';
  //   }
  // }
}
