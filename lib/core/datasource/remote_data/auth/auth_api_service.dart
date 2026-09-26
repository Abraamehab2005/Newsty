import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:news_app/core/datasource/remote_data/auth/auth_dio_config.dart';
abstract class AuthBaseApiService {
  Future<dynamic> post(String endPoint,String baseUrl ,{Map<String, dynamic>? body});
}
class AuthApiService extends AuthBaseApiService {
  final dio = AuthDioConfig.createDio();
  @override
  Future<dynamic> post(String endPoint,String baseUrl,{Map<String,dynamic>? body}) async{
    try {
      final  response = await dio.post(
          endPoint,
          data: jsonEncode(body),
      );
      final responseBody = response.data as Map<String, dynamic>;
      if(response.statusCode! >= 200 && response.statusCode! < 300){
        return responseBody;
      }else{
        throw Exception( responseBody["message"] ?? "Something Went Wrong");
      }
    }
    on DioException catch(e){
      _handleDioError(e);
    }
    catch (e) {
      throw Exception("Failed To Load Data ");
    }
  }
  void _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw Exception("Connection Timeout");
      case DioExceptionType.sendTimeout:
        throw Exception("Send Timeout");
      case DioExceptionType.receiveTimeout:
        throw Exception("Receive Timeout");
      case DioExceptionType.badCertificate:
        throw Exception("Bad Certificate, connection is not secure");
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        switch (statusCode) {
          case 400:
            throw Exception("Bad Request");
          case 401:
            throw Exception("Unauthorized, check your API key");
          case 403:
            throw Exception("Forbidden");
          case 404:
            throw Exception("Not Found");
          case 426:
            throw Exception("This endpoint requires HTTPS/upgrade, check API plan");
          case 429:
            throw Exception("Too many requests, rate limit exceeded");
          case 500:
          case 502:
          case 503:
            throw Exception("Server Error ($statusCode)");
          default:
            throw Exception("Bad Response: $statusCode");
        }
      case DioExceptionType.cancel:
        throw Exception("Request was cancelled");
      case DioExceptionType.connectionError:
        throw Exception("No internet connection");
      case DioExceptionType.unknown:
        throw Exception("Unexpected error: ${e.message}");
      case DioExceptionType.transformTimeout:
        throw Exception("Transform Timeout");
    }
  }
}
