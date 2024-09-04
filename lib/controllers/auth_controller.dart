import 'package:flatmates/repo/auth_repo.dart';
import 'package:flatmates/widgets/bottomBar.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
    var isLoading = false.obs;
  var isError = false.obs;
  String phone= "";

   void submitUserInformation({
    required String phone,
    required String name,
    required String gender,
    required int age,
    required String foodPreference,
    required bool drinking,
    required bool smoking,
    required bool pet,
    required List<String> imagePaths,
  }) async {
    isLoading.value = true;
    isError.value = false;

    try {
      final response = await AuthRepo().submitUserInformation(
        phone: phone,
        name: name,
        gender: gender,
        age: age,
        foodPreference: foodPreference,
        drinking: drinking,
        smoking: smoking,
        pet: pet,
        imagePaths: imagePaths,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Handle successful response4
            Get.to(() => BottomNavigation());
        Get.snackbar('Success', 'User information submitted successfully');
      } else {
        print("response.statusCode");
        print(response.statusCode);
        // Handle other status codes
        isError.value = true;
        Get.snackbar('Error', 'Failed to submit information');
      }
    } catch (e) {
      // Handle error
      isError.value = true;
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyUser(String phone) async {
    isLoading(true);
    try {
      bool userExists = await AuthRepo().checkUserExists(phone:phone);

      if (userExists) {
            Get.to(() => BottomNavigation());
      } else {
        Get.snackbar('Error', 'User does not exist');
        Get.to(()=> UserInformationScreen());
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify user');
    } finally {
      isLoading(false);
    }
  }
}