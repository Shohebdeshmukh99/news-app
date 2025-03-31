import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';
import '../utils/constants.dart';

class NewsService {
  Future<List<NewsArticle>> fetchNews() async {
    final url = Uri.parse(API_URL);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['articles'];
        return data.map((json) => NewsArticle.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw 'Error fetching news: $error';
    }
  }
}
