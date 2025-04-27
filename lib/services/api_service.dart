import 'dart:convert';
import 'dart:developer';
import 'package:arth_ai/models/article_model.dart';
import 'package:arth_ai/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/widgets/snackbar.dart';

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
    required bool newApiCall,
  }) async {
    try {
      final String? apiKey = dotenv.env[Constants.newsApiKey];

      if (apiKey == null || apiKey.isEmpty) {
        throw Exception(Constants.keyNotFound);
      }

      final prefs = await SharedPreferences.getInstance();
      String url = '${Constants.baseNewsUrl}?'
          '${Constants.query}=$query&'
          '${Constants.apiKey}=$apiKey&'
          '${Constants.image}=${Constants.intTrue}&'
          '${Constants.removeDuplicate}=${Constants.intTrue}&'
          '${Constants.language}=${Constants.en}';
      var nextPage = prefs.getString(Constants.nextPage);

      if (nextPage != null && !newApiCall) {
        url = '$url&${Constants.page}=$nextPage';
      }

      final Uri uri = Uri.parse(url);

      final http.Response response = await http.get(uri);

      if (response.statusCode == Constants.successStatusCode) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> articlesJson = data[Constants.results];
        final List<Article> articles = articlesJson
            .map<Article>(
                (json) => Article.fromJson(json as Map<String, dynamic>))
            .toList();

        // Save the next page number for the next API call.
        // If the next page is null or empty, remove the preference to avoid
        // unnecessary API calls which will be returning the same records again.
        if (data.containsKey(Constants.nextPage) &&
            data[Constants.nextPage] != null &&
            data[Constants.nextPage].toString().isNotEmpty) {
          await prefs.setString(Constants.nextPage, data[Constants.nextPage]);
        } else {
          await prefs.remove(Constants.nextPage);
          return [];
        }

        return articles;
      } else {
        throw Exception('${Constants.statusCode}: ${response.statusCode}');
      }
    } on Exception catch (e) {
      AppSnackbar.showSnackbar(
        Constants.failedToFetchNews,
        Constants.somethingWentWrong,
      );
      log('${Constants.errorFetchingNews} $e');
    }
    return Future.value([]);
  }
}
