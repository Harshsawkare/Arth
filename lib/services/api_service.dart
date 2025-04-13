import 'dart:convert';
import 'package:arth_ai/models/article_model.dart';
import 'package:arth_ai/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  /// Searches for news articles based on the provided query.
  ///
  /// This method fetches articles from the NewsAPI.org service by making
  /// an HTTP GET request with the specified search parameters.
  ///
  /// [query] The search term to find relevant articles.
  /// [page] The page number for pagination, defaults to 1.
  /// [pageSize] The number of articles to return per page, defaults to 20.
  ///
  /// Returns a [Future] that resolves to a [List<Article>] containing the search results.
  ///
  /// Throws an [Exception] if the API key is not found or if the API request fails.
  Future<List<Article>> searchArticles({
    required String query,
    int page = 1,
    int pageSize = 20,
  }) async {
    final String? apiKey = dotenv.env[Constants.newsApiKey];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception("API key not found in .env file.");
    }

    final Uri uri = Uri.parse(
        'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey&page=$page&pageSize=$pageSize');

    final http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      debugPrint(data['articles'].runtimeType.toString());
      final List<dynamic> articlesJson = data['articles'];
      final List<Article> articles = articlesJson
          .map<Article>((json) => Article.fromJson(json as Map<String, dynamic>))
          .toList();

      return articles;
    } else {
      throw Exception('Failed to fetch articles: ${response.statusCode}');
    }
  }
}
