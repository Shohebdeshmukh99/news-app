import 'package:intl/intl.dart';

class NewsArticle {
  final String imageUrl;
  final String headline;
  final String shortDescription;
  final String sourceName;
  final DateTime publishedDate;
  final String newsUrl;

  NewsArticle({
    required this.imageUrl,
    required this.headline,
    required this.shortDescription,
    required this.sourceName,
    required this.publishedDate,
    required this.newsUrl,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      imageUrl: json['urlToImage'] ?? '',
      headline: json['title'] ?? '',
      shortDescription: json['description'] ?? '',
      sourceName: json['source']['name'] ?? '',
      publishedDate: DateTime.parse(json['publishedAt'] ?? ''),
      newsUrl: json['url'] ?? '',
    );
  }

  String getFormattedPublishedDate() {
    return DateFormat('MMMM dd, yyyy').format(publishedDate);
  }
}
