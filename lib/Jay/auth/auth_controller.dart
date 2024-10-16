import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs; // Reactive boolean for loading state
  var phone = ''.obs; // Store phone number

  void verifyUser(String phoneNumber) async {
    try {
      isLoading.value = true; // Set loading state to true
      // Simulate verification process
      await Future.delayed(Duration(seconds: 2)); // Replace with actual API call logic

      // Here, implement the logic for verifying the phone number
      // If verification is successful:
      Get.snackbar('Success', 'Verification successful!');
      // Navigate to the next screen, for example:
      Get.toNamed('/home'); // Replace '/home' with your desired route

    } catch (e) {
      Get.snackbar('Error', 'Verification failed: $e');
    } finally {
      isLoading.value = false; // Set loading state back to false
    }
  }
}
