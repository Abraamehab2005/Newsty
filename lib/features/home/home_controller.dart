import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    getEveryThing();
    getTopHeadline();
  }
  bool topHeadLineLoading = true;
  bool everyThingLoading = true;
  String? errorMessage;
  List<NewsArticleModel> newsTopHeadLineList = [];
  List<NewsArticleModel> newsEveryThingList = [];
  ApiService apiService = ApiService();

  getTopHeadline() async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.topHeadlines,
        params: {"country": "us"},
      );
      newsTopHeadLineList = (result["articles"] as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();
      topHeadLineLoading = false;
      errorMessage = null;
    } catch (e) {
      topHeadLineLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  getEveryThing() async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.everything,
        params: {"q": "news"},
      );

      newsEveryThingList = (result["articles"] as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();
      everyThingLoading = false;
      errorMessage = null;
    } catch (e) {
      everyThingLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
