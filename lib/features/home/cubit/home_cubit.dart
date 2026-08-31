import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/repos/news_repository.dart';
import '../../../core/enums/request_status_enum.dart';
import '../models/news_article_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.newsRepository) : super(const HomeState()){
    getEveryThing();
    getTopHeadLine();
  }
  final BaseNewsRepository newsRepository;
  getTopHeadLine({String? category}) async {
    try {

      emit(state.copyWith(
        newsTopHeadLineStates: RequestStatusEnum.loading,
      ));
      final articles = await newsRepository.getTopHeadLine(
        selectedCategory:state.selectedCategory,
      );
      emit(state.copyWith(
        newsTopHeadLineList: articles,
        newsTopHeadLineStates: RequestStatusEnum.loaded,
        errorMessage:null
      ));
    } catch (e) {
      emit(state.copyWith(
        newsTopHeadLineStates: RequestStatusEnum.error,
        errorMessage: e.toString(),
      ));
    }
  }

  getEveryThing() async {
    try {
      final articles = await newsRepository.getEveryThing();
      emit(state.copyWith(
        newsEveryThingList: articles,
        everyThingStatus: RequestStatusEnum.loaded,
        errorMessage:null
      ));
    } catch (e) {
      emit(state.copyWith(
        everyThingStatus: RequestStatusEnum.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void updateSelectedCategory(String category) {
    emit(state.copyWith(
      selectedCategory: category
    ));
    getTopHeadLine(category: state.selectedCategory);
  }
}
