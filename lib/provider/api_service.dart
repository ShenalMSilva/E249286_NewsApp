import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class ApiService {
  final String apiKey = 'ef9fe59a2f2f4ec185f9a0be18ada1c5'; // apikey(shenals@star.lk)
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