import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
abstract class BaseApiService {
  Future<dynamic> get(String endPoint, String baseUrl,{Map<String, dynamic>? params});
  Future<dynamic> post(String endPoint, String baseUrl,{Map<String, dynamic>? body});
  Future<dynamic> getWithToken(String endPoint, String baseUrl,String? token);

}

class ApiService extends BaseApiService {
  @override
  Future<dynamic> get(String endPoint, String baseUrl ,{Map<String, dynamic>? params}) async {
    var url = Uri.http(baseUrl, "v2/$endPoint", {
      "apiKey": ApiConfig.apiKey,
      ...?params,
    });

    print(url);
    try {
      final http.Response response = await http.get(url);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception("Failed To Load Data ");
    }
  }

  @override
  Future<dynamic> post(String endPoint, String baseUrl, {Map<String, dynamic>? body}) async{
    var url = Uri.https(baseUrl, endPoint);
    final Map<String , String> headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
    };
    final token = UserRepository().getUser()?.accessToken;
    if(token != null){
      headers["Authorization"] = "Bearer $token";
    }
    try {
      final http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body)
      );
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      if(response.statusCode >= 200 && response.statusCode < 300){
        return responseBody;
      }else{
        throw Exception( responseBody["message"] ?? "Something Went Wrong");
      }
    } catch (e) {
      throw Exception("Failed To Load Data ");
    }
  }


  @override
  Future<dynamic> getWithToken(String endPoint, String baseUrl, String? token) async{
    var url = Uri.https(baseUrl, endPoint);
    final Map<String , String> headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
    };
    if(token != null){
      headers["Authorization"] = "Bearer $token";
    }
    try {
      final http.Response response = await http.get(
          url,
          headers: headers);
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      if(response.statusCode >= 200 && response.statusCode < 300){
        return responseBody;
      }else{
        throw Exception( responseBody["message"] ?? "Something Went Wrong");
      }
    } catch (e) {
      throw Exception("Failed To Load Data ");
    }
  }
}
