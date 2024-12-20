import 'package:flutter/material.dart';
import 'api_service.dart';
import 'news_model.dart';
import 'category_page.dart';
import 'news_detail_page.dart';

class HomePage extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News App')),
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
                child: Text('View All'),
              ),
            ],
          ),
        ),
        FutureBuilder<List<NewsArticle>>(
          future: apiService.fetchTopHeadlines(category.toLowerCase()), // Fetch top headlines for the category
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
                height: 150, // Set a fixed height for the horizontal list
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
            builder: (context) => NewsDetailPage(article: article), // Navigate to the news detail page
          ),
        );
      },
      child: Container(
        width: 120, // Set a fixed width for each news tile
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                article.urlToImage ?? 'https://via.placeholder.com/120', // Placeholder image if none available
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