import 'package:flutter/material.dart';

import '../models/article.dart';
import '../services/news_service.dart';
import '../widgets/article_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NewsArticle> articles = [];
  List<NewsArticle> filteredArticles = [];
  TextEditingController searchController = TextEditingController();
  final NewsService _newsService = NewsService();

  @override
  void initState() {
    super.initState();
    fetchNews();
    searchController.addListener(_filterArticles);
  }

  Future<void> fetchNews() async {
    try {
      final fetchedArticles = await _newsService.fetchNews();
      setState(() {
        articles = fetchedArticles;
        filteredArticles = articles;
      });
    } catch (error) {
      print('Error fetching news: $error');
    }
  }

  void _filterArticles() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredArticles = articles
          .where((article) =>
      article.headline.toLowerCase().contains(query) ||
          article.shortDescription.toLowerCase().contains(query))
          .toList();
    });
  }

  Future<void> _onRefresh() async {
    await fetchNews();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by title or description',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: filteredArticles.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: filteredArticles.length,
          itemBuilder: (context, index) {
            final article = filteredArticles[index];
            return ArticleTile(article: article);
          },
        ),
      ),
    );
  }
}
