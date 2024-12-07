import 'package:flutter/material.dart';
import '../models/news_model.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsArticle article;

  NewsDetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Mode',
            style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.normal)),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(article.urlToImage),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                article.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: null,
                overflow: TextOverflow.visible,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                article.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Author: ${article.author}'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Published at: ${article.publishedAt}'),
            ),
            TextButton(
              onPressed: () {
                // Open the URL in a web view or browser
              },
              child: Text('Read more'),
            ),
          ],
        ),
      ),
    );
  }
}