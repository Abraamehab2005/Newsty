part of 'bookmark_cubit.dart';


 class BookmarkState extends Equatable{
   const BookmarkState({this.bookmarkStatus = RequestStatusEnum.loading, this.bookmarks = const [], this.errorMessage, this.searchQuery = ''});
  final RequestStatusEnum bookmarkStatus;
  final  List<BookmarkModel> bookmarks ;
  final String? errorMessage;
  final String searchQuery ;

  BookmarkState copyWith({
    RequestStatusEnum? bookmarkStatus,
    List<BookmarkModel>? bookmarks,
    String? errorMessage,
    String? searchQuery,
  }) {
    return BookmarkState(
      bookmarkStatus: bookmarkStatus ?? this.bookmarkStatus,
      bookmarks: bookmarks ?? this.bookmarks,
      errorMessage: errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [bookmarkStatus, bookmarks, errorMessage, searchQuery];
 }


