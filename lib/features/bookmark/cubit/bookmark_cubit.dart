import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../core/enums/request_status_enum.dart';
import '../../home/models/news_article_model.dart';
import '../data/bookmark_repository.dart';
import '../models/bookmark_model.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(const BookmarkState()){
    loadBookmarks();
   }
  final BookmarkRepository _repository = BookmarkRepository();
  void loadBookmarks() {
    try {
      emit(state.copyWith(
        bookmarkStatus: RequestStatusEnum.loading,
      ));
      if (state.searchQuery.isEmpty) {
        emit(state.copyWith(
          bookmarks: _repository.getBookmarks(),
        ));
      } else {
        emit(state.copyWith(
          bookmarks: _repository.searchBookmarks(state.searchQuery),
        ));
      }
      emit(state.copyWith(
        bookmarkStatus: RequestStatusEnum.loaded,
        errorMessage: null
      ));
    } catch (e) {
      emit(state.copyWith(
        bookmarkStatus: RequestStatusEnum.error,
        errorMessage: e.toString()
      ));
    }
  }

  Future<bool> toggleBookmark(NewsArticleModel article) async {
    try {
      final wasAdded = await _repository.toggleBookmark(article);
      loadBookmarks();
      return wasAdded;
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString()
      ));
      return false;
    }
  }

  Future<void> addBookmark(NewsArticleModel article) async {
    try {
      await _repository.addBookmark(article);
      loadBookmarks();
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString()
      ));
    }
  }
  Future<void> removeBookmark(String articleUrl) async {
    try {
      await _repository.removeBookMark(articleUrl);
      loadBookmarks();
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString()
      ));
    }
  }

  bool isArticleBookmarked(String? articleUrl) {
    return _repository.isBookmarked(articleUrl);
  }

  int get bookmarkCount => _repository.getBookmarkCount();
  Future<void> clearAllBookmarks() async {
    try {
      await _repository.clearAllBookmarks();
      loadBookmarks();
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString()
      ));
    }
  }

  void searchBookmark(String query) {
    emit(state.copyWith(
      searchQuery: query
    ));
    loadBookmarks();
  }



  NewsArticleModel getArticleFromBookmark(BookmarkModel bookmark) {
    return _repository.bookmarkToArticle(bookmark);
  }

  Future<void> refresh() async {
    loadBookmarks();
  }

  List<NewsArticleModel> get bookmarksAsArticle {
    return state.bookmarks.map((bookmark) => _repository.bookmarkToArticle(bookmark)).toList();
  }
  }

