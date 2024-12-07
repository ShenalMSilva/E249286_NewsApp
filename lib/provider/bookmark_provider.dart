import 'package:flutter/material.dart';
import '../models/news_model.dart';

class BookmarkProvider with ChangeNotifier {
  List<NewsArticle> _bookmarks = [];

  List<NewsArticle> get bookmarks => _bookmarks;

  void addBookmark(NewsArticle article) {
    _bookmarks.add(article);
    notifyListeners();
  }

  void removeBookmark(NewsArticle article) {
    _bookmarks.remove(article);
    notifyListeners();
  }
}