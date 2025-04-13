// local_db_repository.dart
import '../models/article_model.dart';
import '../services/local_db_service.dart';

class LocalDbRepository implements LocalDBService {
  /// Adds a search result to the local database.
  /// 
  /// Stores a list of [articles] associated with the specified [keyword].
  /// This allows for later retrieval of search results by keyword.
  /// 
  /// [keyword] The search term used to find the articles.
  /// [articles] The list of articles returned from the search.
  /// 
  /// Returns a [Future] that completes when the operation is finished.
  Future<void> addSearchResult(String keyword, List<Article> articles) async {
    await LocalDBService.addSearchResult(keyword, articles);
  }

  /// Deletes a keyword and its associated articles from the local database.
  /// 
  /// [keyword] The search term to be deleted.
  /// 
  /// Returns a [Future] that completes when the deletion is finished.
  Future<void> deleteKeyword(String keyword) async {
    await LocalDBService.deleteKeyword(keyword);
  }

  /// Retrieves articles associated with a specific keyword.
  /// 
  /// [keyword] The search term used to find the articles.
  /// 
  /// Returns a [List<Article>] containing all articles associated with the keyword.
  List<Article> getArticlesForKeyword(String keyword) {
    return LocalDBService.getArticlesForKeyword(keyword);
  }

  /// Retrieves all saved keywords from the local database.
  /// 
  /// Returns a [List<String>] containing all saved search terms.
  List<String> getSavedKeywords() {
    return LocalDBService.getSavedKeywords();
  }

  /// Retrieves all search results stored in the local database.
  /// 
  /// Returns a [List] containing all search results with their associated keywords.
  List getAllSearchResults() {
    return LocalDBService.getAllSearchResults();
  }

  /// Initializes the local database service.
  /// 
  /// This method must be called before any other database operations.
  /// 
  /// Returns a [Future] that completes when the initialization is finished.
  Future<void> initialize() async {
    await LocalDBService.init();
  }
}