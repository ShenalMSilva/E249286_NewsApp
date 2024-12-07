import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news.dart';

class ApiService {
  static const String apiKey = '2d32a492ef9c4601b53ae2ac58ae6ce5';
  static const String baseUrl = 'https://newsapi.org/v2';

  // Fetch top headlines
  static Future<List<News>> fetchHeadlines() async {
    final response = await http.get(Uri.parse('$baseUrl/top-headlines?q=any&apiKey=$apiKey'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['articles'];
      return jsonData.map((json) => News.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load headlines');
    }
  }

  // Fetch news by category
  static Future<List<News>> fetchCategoryNews(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/top-headlines?category=$category&apiKey=$apiKey'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['articles'];
      return jsonData.map((json) => News.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load category news');
    }
  }
}