
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

import '../../../core/enums/request_status_enum.dart';
import '../../../core/repos/news_repository.dart';
import '../../home/models/news_article_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.newsRepository) : super(const SearchState());
  TextEditingController searchController = TextEditingController();
  final BaseNewsRepository newsRepository;
  Future<void> getEveryThing() async {
    try {
      emit(state.copyWith(
        newsEveryThingList:  await newsRepository.getEveryThing(query: searchController.text),
          everyThingStatus: RequestStatusEnum.loaded,
         errorMessage: null
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        everyThingStatus: RequestStatusEnum.error
      ));
    }
  }
}
