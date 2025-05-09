// news_controller.dart
import 'package:arth_ai/services/api_service.dart';
import 'package:arth_ai/utils/constants.dart';
import 'package:arth_ai/views/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/article_model.dart';
import '../services/connectivity_service.dart';
import '../services/local_db_repository.dart';

class NewsController extends GetxController {
  final localDbRepository = LocalDbRepository();
  final connectivity = Get.find<ConnectivityService>();

  /// Controller that manages the scrolling behavior of the list.
  ///
  /// Used to detect when the user has scrolled near the bottom to trigger loading more articles.
  final Rx<ScrollController> scrollController = ScrollController().obs;

  var articles = <Article>[].obs;
  var isLoading = false.obs;
  var searchQuery = ''.obs;
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
    String keyword,
    bool newApiCall, {
    bool reset = true,
    bool showInternetSnackbar = true,
  }) async {
    if (reset) {
      articles.clear();
    }

    searchQuery.value = keyword;
    isLoading.value = true;

    if (connectivity.isOnline.value) {
      if (keyword.isNotEmpty) {
        final fetchedArticles = await ApiService().searchArticles(
          query: keyword,
          newApiCall: newApiCall,
        );

        if (fetchedArticles.isNotEmpty) {
          if (reset) {
            await localDbRepository.deleteKeyword(keyword);
            await localDbRepository.addSearchResult(keyword, fetchedArticles);
          }

          articles.addAll(fetchedArticles);
        } else {
          AppSnackbar.showSnackbar(
            Constants.emptyListTitle,
            Constants.emptyListMessage,
          );
        }
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

  /// Loads more news articles by performing an additional search query.
  ///
  /// This function checks if a search operation is not already in progress and
  /// if the device is online. If both conditions are met, it fetches more articles
  /// based on the current search query without resetting the existing list of articles.
  ///
  /// Returns a [Future<void>] that completes when the load operation is finished.
  void loadMore() async {
    if (!isLoading.value && connectivity.isOnline.value) {
      await searchNews(
        searchQuery.value,
        false,
        reset: false,
      );
    }
  }

  /// Deletes the stored search results for a specific keyword from the local database.
  ///
  /// This function removes all cached articles associated with the provided keyword,
  /// freeing up storage space and ensuring outdated data is not used in future searches.
  ///
  /// Parameters:
  /// - [keyword]: The search term whose associated cached articles should be deleted.
  void deleteOldKeyword(String keyword) {
    localDbRepository.deleteKeyword(keyword);
  }

  /// Scrolls the list to the top position.
  ///
  /// This function animates the scroll position of the list to the top,
  /// providing a smooth scrolling effect.
  ///
  /// The animation duration is set to 300 milliseconds, and the curve used
  /// for the animation is [Curves.easeInOut].
  void scrollToTop() {
    scrollController.value.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    articles.clear();
    isLoading.value = false;
    searchQuery.value = '';
    super.onClose();
  }
}
