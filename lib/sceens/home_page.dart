import 'package:flutter/material.dart';
import '../provider/api_service.dart';
import '../models/news_model.dart';
import 'category_page.dart';
import 'news_detail_page.dart';
import 'search_page.dart';

class HomePage extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App',
        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.normal)),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()), // go to Search page
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildCategorySection(context, 'Business'),
          _buildCategorySection(context, 'Entertainment'),
          _buildCategorySection(context, 'Health'),
          _buildCategorySection(context, 'Science'),
          _buildCategorySection(context, 'Sports'),
          _buildCategorySection(context, 'Technology'),
        ],
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, String category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(category: category),
                    ),
                  );
                },
                child: Text ('View All'),
              ),
            ],
          ),
        ),
        FutureBuilder<List<NewsArticle>>(
          future: apiService.fetchTopHeadlines(category.toLowerCase()), // Fetch top headlines
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 150,
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Container(
                height: 150,
                child: Center(child: Text('Error: ${snapshot.error}')),
              );
            } else {
              return Container(
                height: 150, // height for the list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length > 5 ? 5 : snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final article = snapshot.data![index];
                    return _buildNewsTile(context, article);
                  },
                ),
              );
            }
          },
        ),
        Divider(),
      ],
    );
  }

  Widget _buildNewsTile(BuildContext context, NewsArticle article) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailPage(article: article), // go to detailed page
          ),
        );
      },
      child: Container(
        width: 120, // Set width for tile
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                article.urlToImage ?? 'https://via.placeholder.com/120',
                height: 100,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              article.title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}