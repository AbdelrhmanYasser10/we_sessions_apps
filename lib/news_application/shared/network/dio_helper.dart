import 'package:dio/dio.dart';

abstract class DioHelper{
   static Dio? _dio;

   static Future<void> initializeDio()async{
     _dio ??= Dio(
         BaseOptions(
           baseUrl: "https://newsapi.org/v2/",
           receiveDataWhenStatusError: true,
           validateStatus: (status) => status! <= 500,
         ),
       );
   }

   static Future<Response> getRequest({
     required String endPoint,
     Map<String,dynamic>? queryParameters
   })async{
     return await _dio!.get(endPoint,queryParameters: queryParameters);
   }
   static Future<Response> postRequest({
     required String endPoint,
     Map<String,dynamic>? queryParameters
   })async{
     return await _dio!.post(endPoint,queryParameters: queryParameters);
   }
}