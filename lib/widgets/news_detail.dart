import 'package:flutter/material.dart';
import '../models/news.dart';

class NewsDetailPage extends StatelessWidget {
  final News news;

  NewsDetailPage({required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(news.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(news.urlToImage),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                news.content,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Text('Author: ${news.author ?? "Unknown"}'),
            Text('Published at: ${news.publishedAt}'),
            TextButton(
              onPressed: () {
                // Open URL in a web browser
                // You can use url_launcher package for this
              },
              child: Text('Read more'),
            ),
          ],
        ),
      ),
    );
  }
}