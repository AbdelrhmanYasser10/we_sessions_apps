import 'package:dio/dio.dart';

abstract class DioHelper{

  static Dio? _dio;
  static Future<void> initializeDio()async{

    _dio = Dio(
      BaseOptions(
        baseUrl: "https://jsonplaceholder.typicode.com/",
        receiveDataWhenStatusError: true,
        receiveTimeout: const Duration(seconds: 60),
        validateStatus: (status) {
          return status! <= 505;
        },
      ),
    );

  }

  static Future<Response> getRequest({
  required String endPoint,
  Map<String,dynamic>? queryParamters,
}) async {
    return await _dio!.get(endPoint,queryParameters: queryParamters);
  }
}