import 'package:hive_ce_flutter/adapters.dart';
import 'package:news_app/core/constans/constans.dart';
import 'package:news_app/features/bookmark/models/bookmark_model.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class BookmarkRepository {
  BookmarkRepository._internal();
  static final BookmarkRepository _instance = BookmarkRepository._internal();
  factory BookmarkRepository() => _instance;
  Box<BookmarkModel>? _bookmarkBox;
  Box<BookmarkModel> get bookmarkBox {
    if (_bookmarkBox == null) {
      throw Exception("BookmarkRepository not initialized");
    }
    return _bookmarkBox!;
  }

  Future<void> init() async {
    Hive.registerAdapter(BookmarkModelAdapter());
    _bookmarkBox = await Hive.openBox<BookmarkModel>(Constans.bookmarkBox);
  }

  Future<void> addBookmark(NewsArticleModel article) async {
    final bookmark = BookmarkModel(
      author: article.author,
      title: article.title ?? "",
      description: article.description,
      url: article.url ?? "",
      urlToImage: article.urlToImage,
      publishedAt: article.publishedAt,
      content: article.content,
      bookmarkedAt: DateTime.now(),
    );
    await bookmarkBox.put(article.url, bookmark);
  }

  Future<void> removeBookMark(String articleUrl) async {
    await bookmarkBox.delete(articleUrl);
  }

  List<BookmarkModel> getBookmarks() {
    return bookmarkBox.values.toList();
  }

  bool isBookmarked(String? articleUrl) {
    if (articleUrl == null || articleUrl.isEmpty) return false;
    return bookmarkBox.containsKey(articleUrl);
  }

  BookmarkModel? getBookmark(String articleUrl) {
    return bookmarkBox.get(articleUrl);
  }

  Future<bool> toggleBookmark(NewsArticleModel article) async {
    if (isBookmarked(article.url)) {
      await removeBookMark(article.url!);
      return false;
    } else {
      await addBookmark(article);
      return true;
    }
  }

  int getBookmarkCount() {
    return bookmarkBox.length;
  }

  Future<void> clearAllBookmarks() async {
    await bookmarkBox.clear();
  }

  List<BookmarkModel> searchBookmarks(String query) {
    if (query.isEmpty) return getBookmarks();
    final lowercashQuery = query.toLowerCase();
    return bookmarkBox.values.where((bookmark) {
      final titleMatch = bookmark.title.toLowerCase().contains(lowercashQuery);
      final descriptionMatch =
          bookmark.description?.toLowerCase().contains(lowercashQuery) ?? false;
      final authorMatch =
          bookmark.author?.toLowerCase().contains(lowercashQuery) ?? false;
      return titleMatch || descriptionMatch || authorMatch;
    }).toList()..sort((a, b) => b.bookmarkedAt.compareTo(a.bookmarkedAt));
  }

  NewsArticleModel bookmarkToArticle(BookmarkModel bookmark) {
    return NewsArticleModel(
      author: bookmark.author,
      title: bookmark.title,
      description: bookmark.description,
      url: bookmark.url,
      urlToImage: bookmark.urlToImage,
      publishedAt: bookmark.publishedAt,
      content: bookmark.content,
    );
  }
}
