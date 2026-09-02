part of 'search_cubit.dart';


 class SearchState extends Equatable{
   const SearchState({this.errorMessage, this.everyThingStatus = RequestStatusEnum.loading, this.newsEveryThingList = const []});
   final String? errorMessage;
   final RequestStatusEnum everyThingStatus;
   final List<NewsArticleModel> newsEveryThingList;

  SearchState copyWith({
    String? errorMessage,
    RequestStatusEnum? everyThingStatus,
    List<NewsArticleModel>? newsEveryThingList,
  }) {
    return SearchState(
      errorMessage: errorMessage ?? this.errorMessage,
      everyThingStatus: everyThingStatus ?? this.everyThingStatus,
      newsEveryThingList: newsEveryThingList ?? this.newsEveryThingList,
    );
  }

  @override
  List<Object?> get props => [errorMessage, everyThingStatus, newsEveryThingList];
 }


