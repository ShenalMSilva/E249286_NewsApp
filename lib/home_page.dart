import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/news.dart';
import 'category_page.dart';
import 'bookmarks_page.dart';
import 'settings_page.dart';
import 'widgets/news_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<News> headlines = [];
  List<String> categories = ['Business', 'Entertainment', 'Health', 'Science', 'Sports', 'Technology'];

  @override
  void initState() {
    super.initState();
    fetchHeadlines();
  }

  fetchHeadlines() async {
    headlines = await ApiService.fetchHeadlines();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News App')),
      body: Column(
        children: [
          // Headlines
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: headlines.length,
              itemBuilder: (context, index) {
                return NewsTile(news: headlines[index]);
              },
            ),
          ),
          // Categories
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(categories[index]),
                      trailing: TextButton(
                        child: Text('View All'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryPage(category: categories[index]),
                            ),
                          );
                        },
                      ),
                    ),
                    // Fetch and display top 5 news items for each category
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Bookmarks'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BookmarksPage()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
          }
        },
      ),
    );
  }
}