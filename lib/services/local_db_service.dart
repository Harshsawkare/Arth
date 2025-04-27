import 'package:arth_ai/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/article_model.dart';
import '../models/source_model.dart';
import '../models/search_result_model.dart';

abstract class LocalDBService {
  static const String _boxName = Constants.dbName;
  static Box<SearchResult>? _box;

  /// Initializes the local database service.
  /// 
  /// This method must be called before any other methods in this service.
  /// It registers the necessary Hive adapters for [Article], [Source], and [SearchResult] models
  /// if they haven't been registered already, and opens the Hive box for storing search results.
  /// 
  /// Throws an exception if the box cannot be opened.
  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(ArticleAdapter().typeId)) {
      Hive.registerAdapter(ArticleAdapter());
    }
    if (!Hive.isAdapterRegistered(SourceAdapter().typeId)) {
      Hive.registerAdapter(SourceAdapter());
    }
    if (!Hive.isAdapterRegistered(SearchResultAdapter().typeId)) {
      Hive.registerAdapter(SearchResultAdapter());
    }

    _box = await Hive.openBox<SearchResult>(_boxName);
  }

  /// Returns the Hive box for search results.
  /// 
  /// Provides access to the underlying Hive box that stores [SearchResult] objects.
  /// 
  /// Returns:
  ///   The opened Hive box containing search results.
  /// 
  /// Throws:
  ///   An [Exception] if the box is not initialized or not open.
  static Box<SearchResult> get box {
    if (_box == null || !_box!.isOpen) {
      throw Exception("Hive box is not open. Call init() first.");
    }
    return _box!;
  }

  /// Adds a new search result to the local database.
  /// 
  /// Stores a search result consisting of a keyword and associated articles.
  /// Limits the stored articles to a maximum of 10 per keyword.
  /// If the database already contains 5 keywords and the new keyword doesn't exist,
  /// the oldest search result (by timestamp) will be removed to maintain the limit.
  /// 
  /// Parameters:
  ///   [keyword] - The search term to store.
  ///   [articles] - The list of articles associated with the search term.
  /// 
  /// Returns a [Future] that completes when the operation is finished.
  static Future<void> addSearchResult(String keyword, List<Article> articles) async {
    final limitedArticles = articles.take(Constants.maxSearchArticleLimit).toList();

    if (!box.containsKey(keyword) && box.length >= Constants.maxSearchKeyLimit) {
      // Sort all items by timestamp ascending
      final sorted = box.toMap().entries.toList()
        ..sort((a, b) => a.value.timestamp.compareTo(b.value.timestamp));

      final oldestKey = sorted.first.key;
      await box.delete(oldestKey);
    }

    final result = SearchResult(
      keyword: keyword,
      articles: limitedArticles,
      timestamp: DateTime.now(),
    );
    await box.put(keyword, result);
  }

  /// Retrieves articles associated with a specific keyword.
  /// 
  /// Looks up the stored search result for the given keyword and returns
  /// its associated articles.
  /// 
  /// Parameters:
  ///   [keyword] - The search term to look up.
  /// 
  /// Returns:
  ///   A list of [Article] objects associated with the keyword.
  ///   Returns an empty list if the keyword is not found.
  static List<Article> getArticlesForKeyword(String keyword) {
    final result = box.get(keyword);
    return result?.articles ?? [];
  }

  /// Deletes a search result by its keyword.
  /// 
  /// Removes the search result with the specified keyword from the database.
  /// 
  /// Parameters:
  ///   [keyword] - The keyword of the search result to delete.
  /// 
  /// Returns a [Future] that completes when the deletion is finished.
  static Future<void> deleteKeyword(String keyword) async {
    await box.delete(keyword);
  }

  /// Retrieves all saved keywords in chronological order.
  /// 
  /// Returns a list of all keywords stored in the database,
  /// sorted by timestamp in descending order (newest first).
  /// 
  /// Returns:
  ///   A list of keyword strings sorted by recency.
  static List<String> getSavedKeywords() {
    final sortedResults = box.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp)); // Descending
    return sortedResults.map((result) => result.keyword).toList();
  }

  /// Retrieves all saved search results.
  /// 
  /// Returns:
  ///   A list of all [SearchResult] objects stored in the database.
  static List<SearchResult> getAllSearchResults() => box.values.toList();
}
