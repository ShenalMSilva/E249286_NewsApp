import 'package:flutter/material.dart';
import 'provider/api_service.dart';
import 'models/news_model.dart';
import 'screens/home_page.dart';
import 'screens/bookmarks_page.dart';
import 'screens/settings_page.dart';
import 'provider/bookmark_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ValueNotifier<bool> _isDarkMode = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isDarkMode,
      builder: (context, isDarkMode, child) {
        return ChangeNotifierProvider(
          create: (context) => BookmarkProvider(),
          child: MaterialApp(
            title: 'News App',
            theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: MainPage(isDarkModeNotifier: _isDarkMode),
          ),
        );
      },
    );
  }
}

class MainPage extends StatefulWidget {
  final ValueNotifier<bool> isDarkModeNotifier;

  MainPage({required this.isDarkModeNotifier});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    BookmarksPage(),
    SettingsPage(isDarkModeNotifier: ValueNotifier(false)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Bookmarks'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}