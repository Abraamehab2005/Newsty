import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/features/home/models/news_article_model.dart';
import 'package:news_app/features/home/repos/news_repository.dart';



class HomeController extends ChangeNotifier with SafeNotifyMixin{
  HomeController(this.newsRepository) {
    getEveryThing();
    getTopHeadLine();
  }

  RequestStatusEnum everyThingStatus = RequestStatusEnum.loading;
  RequestStatusEnum newsTopHeadLineStates = RequestStatusEnum.loading;

  String? errorMessage;
  String? selectedCategory;

  List<NewsArticleModel> newsTopHeadLineList = [];
  List<NewsArticleModel> newsEveryThingList = [];
  final BaseNewsRepository newsRepository;

  getTopHeadLine({String? category}) async {
    try {
      newsTopHeadLineStates = RequestStatusEnum.loading;
      notifyListeners();
      newsTopHeadLineList = await newsRepository.getTopHeadLine(
        selectedCategory: selectedCategory,
      );

      newsTopHeadLineStates = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      newsTopHeadLineStates = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }

  getEveryThing() async {
    try {
      newsEveryThingList = await newsRepository.getEveryThing();
      everyThingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      everyThingStatus = RequestStatusEnum.error;
    }
    safeNotify();
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    getTopHeadLine(category: selectedCategory);
    safeNotify();
  }

  
}
