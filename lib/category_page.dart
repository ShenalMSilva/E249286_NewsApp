import 'package:flutter/material.dart';
import 'api_service.dart';
import 'news_model.dart';
import 'news_detail_page.dart';
import 'provider/bookmark_provider.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  final String category;
  final ApiService apiService = ApiService();

  CategoryPage({required this.category});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isAlphabeticalOrder = false; // State variable to track sorting order

  void toggleSortOrder() {
    setState(() {
      isAlphabeticalOrder = !isAlphabeticalOrder; // Toggle the sorting order
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        actions: [
          IconButton(
            icon: Icon(isAlphabeticalOrder ? Icons.sort_by_alpha : Icons.sort),
            onPressed: () {
              toggleSortOrder(); // Toggle sorting order when button is pressed
            },
          ),
        ],
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: widget.apiService.fetchTopHeadlines(widget.category.toLowerCase()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Sort the articles based on the selected order
            List<NewsArticle> articles = snapshot.data!;
            if (isAlphabeticalOrder) {
              articles.sort((a, b) => a.title.compareTo(b.title)); // Sort alphabetically by title
            }

            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Margin around the tile
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color of the tile
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: Offset(0, 3), // Offset of the shadow
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners for the image
                      child: Image.network(
                        article.urlToImage,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      article.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.bookmark),
                      onPressed: () {
                        if (article.id != null) {
                          Provider.of<BookmarkProvider>(context, listen: false).addBookmark(article);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Article bookmarked!')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Cannot bookmark article without ID')),
                          );
                        }
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailPage(article: article),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}