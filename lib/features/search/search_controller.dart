import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class SearchScreenController extends ChangeNotifier with SafeNotifyMixin {
  SearchScreenController(this.newsRepository);

  TextEditingController searchController = TextEditingController();
  final BaseNewsRepository newsRepository;
  String? errorMessage;
  RequestStatusEnum everyThingStatus = RequestStatusEnum.loading;

  List<NewsArticleModel> newsEveryThingList = [];
  getEveryThing() async {
    try {
      newsEveryThingList = await newsRepository.getEveryThing(query: searchController.text);
      everyThingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      everyThingStatus = RequestStatusEnum.error;
    }
    safeNotify();
  }
}
