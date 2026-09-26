import 'package:dio/dio.dart';
import '../auth/auth_api_config.dart';
import '../interceptors/logging_interceptors.dart';
import 'news_api_config.dart';
class NewsDioConfig {
  static Dio createDio(){
    final dio =  Dio(
      BaseOptions(
        connectTimeout:const Duration(seconds: 30),
        baseUrl: NewsApiConfig.newsBaseUrl,
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