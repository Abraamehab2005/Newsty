import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';

import '../../../../features/auth/login_screen.dart';
import '../../../../main.dart';
import '../../local_data/user_repository.dart';

class AuthInterceptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String? token = UserRepository().getUser()?.accessToken;
    if(token != null){
      options.headers["Authorization"] = "Bearer $token";
    }
    handler.next(options);
    }
   @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
     if(err.response?.statusCode == 401){
       final BuildContext context = navigationKey.currentContext!;
       UserRepository().delete();
       PreferencesManager().clear();
       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Session Expire, Please Login Again")));
     }
     handler.next(err);
    }
  }

