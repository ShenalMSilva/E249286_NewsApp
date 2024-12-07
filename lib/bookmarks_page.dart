import 'package:flutter/material.dart';
import 'models/news.dart';
import 'widgets/news_tile.dart';

class BookmarksPage extends StatelessWidget {
  final List<News> bookmarkedNews = []; // This should be populated with saved bookmarks

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bookmarks')),
      body: ListView.builder(
        itemCount: bookmarkedNews.length,
        itemBuilder: (context, index) {
          return NewsTile(news: bookmarkedNews[index]);
        },
      ),
    );
  }
}