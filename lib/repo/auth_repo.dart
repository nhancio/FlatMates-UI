/*
import 'package:dio/dio.dart';
import 'package:flatmates/network/network_service.dart';

class AuthRepo {
  Future<Response> submitUserInformation({
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
    // FormData formData = FormData.fromMap();
    var body = {
      'name': name,
      'gender': gender,
      'age': age,
      'food_choice': foodPreference,
      'drinking': drinking,
      'smoking': smoking,
      'pet': pet,
      'phone_number': phone
      // 'images': [
      //   for (String path in imagePaths)
      //     await MultipartFile.fromFile(path),
      // ],
    };
    try {
      Response response = await NetworkService().postRequest(
        '/profile/',
        body,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkUserExists({required String phone}) async {
     try {
         Response response = await NetworkService().getRequest('/profile/$phone');
      if (response.statusCode == 200 && response.data['exists'] == true) {
        return true; // User exists
      } else {
        return false; // User does not exist
      }
    } catch (e) {
      throw Exception('Failed to check user: $e');
    }
    // return response;
  }
}
*/
