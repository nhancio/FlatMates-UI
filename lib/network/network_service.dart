import 'package:dio/dio.dart';

class NetworkService {
  late Dio dio;

  NetworkService() {
    dio = Dio(BaseOptions(
      baseUrl: 'http://16.16.24.201:8000/api', // Replace with your base URL
      connectTimeout: const Duration(seconds: 5000),
      receiveTimeout: const Duration(seconds: 3000),
      headers: {'Content-Type': 'application/json'},
      validateStatus: (status) {
            return status != null; // Accept all status codes
          },
    ));
  }

  Future<Response> getRequest(String endpoint) async {
    try {
      Response response = await dio.get(endpoint);
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> postRequest(
      String endpoint, Map<String, dynamic> data) async {
        print("data");
        print(data);
    try {
      Response response = await dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> postRequestFormData(
      String endpoint, FormData formData) async {
    try {
      Response response = await dio.post(endpoint, data: formData);
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}
