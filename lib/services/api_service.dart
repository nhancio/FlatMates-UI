import 'package:dio/dio.dart';
import 'package:flatemates_ui/models/user_model.dart';
import 'package:retrofit/retrofit.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: "http://20.193.152.22:8000/api/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("profile/")
  Future<void> registerUser(@Body() User user);
}

Dio getDio() {
  final dio = Dio();
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      print('Request: ${options.method} ${options.path}');
      return handler.next(options);
    },
    onResponse: (response, handler) {
      print('Response: ${response.data}');
      return handler.next(response);
    },
    onError: (DioError e, handler) {
      print('Error: ${e.response?.data}');
      return handler.next(e);
    },
  ));
  return dio;
}
