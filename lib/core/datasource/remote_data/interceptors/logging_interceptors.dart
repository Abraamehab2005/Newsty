import 'dart:developer';
import 'package:dio/dio.dart';
class LoggingInterceptors  extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("BaseUrl =${options.baseUrl}");
    log("Method = ${options.method}");
    log("Uri =${options.uri}");
    if(options.queryParameters.isNotEmpty){
      log("Query Parameters =${options.queryParameters}");
    }
    if(options.data != null){
      log("Data =${options.data}");
    }
    handler.next(options);
  }
  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    log("Response = ${response.data}");
    log("States = ${response.statusCode}");
    handler.next(response);
  }
}