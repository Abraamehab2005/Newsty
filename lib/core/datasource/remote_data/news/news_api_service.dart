import 'package:dio/dio.dart';
import 'news_dio_config.dart';
abstract class BaseNewsApiService {
  Future<dynamic> get(String endPoint,{Map<String, dynamic>? params});


}

class NewsApiService extends BaseNewsApiService {
  final dio = NewsDioConfig.createDio();
  @override
  Future<dynamic> get(String endPoint,{Map<String, dynamic>? params}) async {
    try {
      final response = await dio.get(endPoint , queryParameters:params);
      return response.data as Map<String, dynamic>;
    }
     on DioException catch(e){
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
    catch (e) {
      throw Exception("Failed To Load Data ");
    }
  }
}
