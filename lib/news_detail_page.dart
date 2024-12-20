import 'package:flutter/material.dart';
import 'news_model.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsArticle article;

  NewsDetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Mode'), // You can change this to any title you prefer
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(article.urlToImage),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                article.title, // Display the full title here
                style: TextStyle(
                  fontSize: 24, // Adjust font size as needed
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center, // Center align the title
                maxLines: null, // Allow multiple lines
                overflow: TextOverflow.visible, // Ensure it shows all text
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                article.description,
                style: TextStyle(fontSize: 16), // Adjust font size as needed
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