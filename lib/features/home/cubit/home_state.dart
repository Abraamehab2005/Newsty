part of 'home_cubit.dart';
 class HomeState extends Equatable {
  const HomeState({
     this.everyThingStatus = RequestStatusEnum.loading,
     this.newsTopHeadLineStates = RequestStatusEnum.loading,
     this.selectedCategory,
     this.newsTopHeadLineList = const [],
     this.newsEveryThingList = const [],
     this.errorMessage,
   });
  final RequestStatusEnum everyThingStatus ;
  final RequestStatusEnum newsTopHeadLineStates;
  final String? errorMessage;
  final String? selectedCategory;
  final List<NewsArticleModel> newsTopHeadLineList;
  final  List<NewsArticleModel> newsEveryThingList;

  HomeState copyWith({
    RequestStatusEnum? everyThingStatus,
    RequestStatusEnum? newsTopHeadLineStates,
    String? errorMessage,
    String? selectedCategory,
    List<NewsArticleModel>? newsTopHeadLineList,
    List<NewsArticleModel>? newsEveryThingList,
  }) {
    return HomeState(
      everyThingStatus: everyThingStatus ?? this.everyThingStatus,
      newsTopHeadLineStates:
          newsTopHeadLineStates ?? this.newsTopHeadLineStates,
      errorMessage: errorMessage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      newsTopHeadLineList: newsTopHeadLineList ?? this.newsTopHeadLineList,
      newsEveryThingList: newsEveryThingList ?? this.newsEveryThingList,
    );
  }

   @override
   List<Object?> get props => [
     everyThingStatus,
     newsTopHeadLineStates,
     errorMessage,
     selectedCategory,
     newsTopHeadLineList,
     newsEveryThingList,
 ];
}

