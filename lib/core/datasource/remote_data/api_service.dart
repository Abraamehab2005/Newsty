import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/core/datasource/remote_data/api_config.dart';
abstract class BaseApiService {
  Future<dynamic> get(String endPoint, String baseUrl,{Map<String, dynamic>? params});
  Future<dynamic> post(String endPoint, String baseUrl, {Map<String, dynamic>? body});
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
    print(url);
    try {
      final http.Response response = await http.post(
          url,
          headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
          }, body: jsonEncode(body));
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception("Failed To Load Data ");
    }
  }
}
