import 'package:dio/dio.dart';
import 'package:news_app/core/datasource/remote_data/interceptors/auth_interceptor.dart';
import '../interceptors/logging_interceptors.dart';
import 'auth_api_config.dart';
class AuthDioConfig {
  static Dio createDio(){
    final dio =  Dio(
      BaseOptions(
          connectTimeout:const Duration(seconds: 30),
          baseUrl: AuthApiConfig.authBaseUrl,
          headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
          }
      ),
    );
    dio.interceptors.addAll([AuthInterceptor(),LoggingInterceptors()]);
    return dio;
  }
}