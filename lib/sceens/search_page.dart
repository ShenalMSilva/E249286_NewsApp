import 'package:flutter/material.dart';
import '../provider/api_service.dart';
import '../models/news_model.dart';
import 'news_detail_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ApiService apiService = ApiService();
  List<NewsArticle> articles = [];
  List<NewsArticle> filteredArticles = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  Future<void> _fetchArticles() async {
    List<NewsArticle> fetchedArticles = await apiService.fetchTopHeadlines('general');
    setState(() {
      articles = fetchedArticles;
      filteredArticles = fetchedArticles; // show all articles at start
    });
  }

  void _filterArticles(String query) {
    setState(() {
      searchQuery = query;
      filteredArticles = articles
          .where((article) => article.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search News',
            style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.normal)),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: _filterArticles,
              decoration: InputDecoration(
                hintText: 'Search news by title...',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: filteredArticles.length,
                itemBuilder: (context, index) {
                  final article = filteredArticles[index];
                  return ListTile(
                    title: Text(article.title),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailPage(article: article),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}