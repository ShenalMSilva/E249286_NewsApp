import 'dart:convert';
import 'package:http/http.dart' as http;
import 'news_model.dart';

class ApiService {
  final String apiKey = '9494c68d315a4b2080acf42ba04bb5ef';
  final String baseUrl = 'https://newsapi.org/v2';

  Future<List<NewsArticle>> fetchTopHeadlines(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/top-headlines?category=$category&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['articles'];
      return jsonData.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}