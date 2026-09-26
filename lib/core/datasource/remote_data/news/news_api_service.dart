import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/datasource/remote_data/auth/auth_api_config.dart';

import 'news_api_config.dart';
import 'news_dio_config.dart';
abstract class BaseNewsApiService {
  Future<dynamic> get(String endPoint,{Map<String, dynamic>? params});


}

class NewsApiService extends BaseNewsApiService {
  final dio = NewsDioConfig.createDio();
  @override
  Future<dynamic> get(String endPoint,{Map<String, dynamic>? params}) async {
    try {
      final response = await dio.get(endPoint , queryParameters:{
        "apiKey": NewsApiConfig.apiKey,
        ...?params,
      });
      return response.data as Map<String, dynamic>;
    }
     on DioException catch(e){

     }
    catch (e) {
      throw Exception("Failed To Load Data ");
    }
  }

}
