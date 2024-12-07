import 'package:flutter/material.dart';
import '../provider/bookmark_provider.dart';
import 'package:provider/provider.dart';
import 'news_detail_page.dart';

class BookmarksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookmarks = Provider.of<BookmarkProvider>(context).bookmarks;

    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks',
          style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.normal)),
        backgroundColor: Colors.teal,),
      body: ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (context, index) {
          final article = bookmarks[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              leading: Image.network(
                article.urlToImage,
                width: 100,
                fit: BoxFit.cover,
              ),
              title: Text(article.title),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailPage(article: article),
                  ),
                );
              },
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  Provider.of<BookmarkProvider>(context, listen: false).removeBookmark(article);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}