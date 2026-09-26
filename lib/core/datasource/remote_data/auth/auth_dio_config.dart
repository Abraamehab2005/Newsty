import 'package:dio/dio.dart';
import '../interceptors/logging_interceptors.dart';
class AuthDioConfig {
  static Dio createDio(){
    final dio =  Dio(
      BaseOptions(
          connectTimeout:const Duration(seconds: 30),
          baseUrl: "https://dummyjson.com/",
          headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
          }
      ),
    );
    dio.interceptors.addAll([LoggingInterceptors()]);
    return dio;
  }
}