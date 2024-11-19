import 'package:dio/dio.dart';
import 'package:flatemates_ui/models/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(
    baseUrl:
        "https://c1c4-2401-4900-1c0e-3c54-e010-7053-9383-6694.ngrok-free.app/api/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("profile/")
  Future<void> registerUser(@Body() User user);
}

Dio getDio() {
  final dio = Dio();
  dio.options = BaseOptions(
    baseUrl:
        'https://c1c4-2401-4900-1c0e-3c54-e010-7053-9383-6694.ngrok-free.app/api/',
    validateStatus: (status) {
      // Accept any status code between 200 and 299 as a valid response
      return status != null && status >= 200 && status < 300;
    },
  );
  dio.options.headers = {
    'Content-Type': 'application/json',
  };
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      print('Request: ${options.method} ${options.path}');
      return handler.next(options);
    },
    onResponse: (response, handler) {
      print('Response: ${response.data}');
      return handler.next(response);
    },
    onError: (DioException e, handler) {
      print('Error: ${e.response?.data}');
      return handler.next(e);
    },
  ));
  return dio;
}
