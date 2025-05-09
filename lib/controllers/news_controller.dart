// news_controller.dart
import 'package:arth_ai/services/api_service.dart';
import 'package:arth_ai/utils/constants.dart';
import 'package:arth_ai/views/widgets/snackbar.dart';
import 'package:get/get.dart';
import '../models/article_model.dart';
import '../services/connectivity_service.dart';
import '../services/local_db_repository.dart';

class NewsController extends GetxController {
  // final newsApiService = NewsApiService();
  final localDbRepository = LocalDbRepository();
  final connectivity = Get.find<ConnectivityService>();

  var articles = <Article>[].obs;
  var isLoading = false.obs;
  var searchQuery = ''.obs;
  var page = 1.obs;
  var showWebView = false.obs;

  /// Searches for news articles based on the provided keyword.
  ///
  /// This method fetches articles from the API if online, or retrieves cached articles
  /// from the local database if offline. It updates the [articles] list with the results.
  ///
  /// Parameters:
  /// - [keyword]: The search term used to find relevant news articles.
  /// - [reset]: When true, clears existing articles and resets pagination to page 1.
  ///   Defaults to true.
  /// - [showInternetSnackbar]: Controls whether to show a snackbar notification when
  ///   offline. Defaults to true.
  ///
  /// Returns a [Future<void>] that completes when the search operation is finished.
  Future<void> searchNews(
    String keyword, {
    bool reset = true,
    bool showInternetSnackbar = true,
  }) async {
    if (reset) {
      page.value = 1;
      articles.clear();
    }

    searchQuery.value = keyword;
    isLoading.value = true;

    if (connectivity.isOnline.value) {
      if (keyword.isNotEmpty) {
        final fetchedArticles =
            await ApiService().searchArticles(query: keyword, page: page.value);

        if (reset) {
          await localDbRepository.deleteKeyword(keyword);
          await localDbRepository.addSearchResult(keyword, fetchedArticles);
        }

        articles.addAll(fetchedArticles);
        page.value += 1;
      } else {
        AppSnackbar.showSnackbar(
          Constants.invalidSearchTextTitle,
          Constants.invalidSearchTextMessage,
        );
      }
    } else {
      final offlineArticles = localDbRepository.getArticlesForKeyword(keyword);
      if (reset) articles.clear();
      if (showInternetSnackbar) {
        AppSnackbar.showSnackbar(
          Constants.noConnectionTitle,
          Constants.noConnectionMessage,
        );
      }
      articles.addAll(offlineArticles);
    }

    isLoading.value = false;
  }

  void loadMore() async {
    if (!isLoading.value && connectivity.isOnline.value) {
      await searchNews(searchQuery.value, reset: false);
    }
  }

  void deleteOldKeyword(String keyword) {
    localDbRepository.deleteKeyword(keyword);
  }

  @override
  void onClose() {
    articles.clear();
    isLoading.value = false;
    searchQuery.value = '';
    page.value = 1;
    super.onClose();
  }
}
