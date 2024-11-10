import 'dart:io';
import 'package:flatemates_ui/auth/auth_controller.dart';
import 'package:flatemates_ui/models/user_model.dart';
import 'package:flatemates_ui/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController extends GetxController {
  final ApiService _apiService = ApiService(getDio());
  final AuthController authController = Get.put(AuthController());

  final nameController = TextEditingController();
  final professionController = TextEditingController();
  final ageController = TextEditingController();
  String? selectedGender;
  File? profileImage;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      update();
    }
  }

  Future<void> registerUser() async {
    if (!_validateForm()) return;

    final user = User(
      phoneNumber: authController.phone.value, // Replace with actual value
      name: nameController.text,
      gender: selectedGender!,
      age: int.tryParse(ageController.text),
      location: '',
      foodChoice: '',
      drinking: false,
      smoking: false,
      pet: false,
    );

    try {
      await _apiService.registerUser(user);
      Get.snackbar('Success', 'User registered successfully!');
      Get.toNamed('/preferences');
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'Failed to register user: $e');
    }
  }

  bool _validateForm() {
    if (nameController.text.isEmpty ||
        selectedGender == null ||
        ageController.text.isEmpty ||
        profileImage == null) {
      Get.snackbar(
        'Error',
        'Please fill all required fields and upload your profile picture.',
      );
      return false;
    }
    return true;
  }
}
