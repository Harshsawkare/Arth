import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'news_controller.dart';

/// A controller that manages the search box functionality in the application.
///
/// This controller handles the state and behavior of the search box, including
/// activation, clearing, and submitting search queries.
class SearchBoxController extends GetxController {
  /// Indicates whether the search box is currently active.
  var isActive = false.obs;

  /// The current text in the search box.
  var searchText = ''.obs;

  /// Controller for the search text field.
  final searchController = TextEditingController();

  /// Focus node for the search text field.
  final focusNode = FocusNode().obs;

  /// Reference to the news controller for performing searches.
  final NewsController newsController = Get.find<NewsController>();

  /// Activates the search box and sets focus to it.
  ///
  /// This method sets the search box to active state and requests focus
  /// after a short delay to ensure the UI has updated.
  void activate() {
    isActive.value = true;
    Future.delayed(const Duration(milliseconds: 100), () {
      focusNode.value.requestFocus();
    });
  }

  /// Clears the search box and deactivates it.
  ///
  /// This method resets the search text, clears the text controller,
  /// deactivates the search box, and releases the focus.
  void clearSearch() {
    searchText.value = '';
    searchController.clear();
    isActive.value = false;
    focusNode.close();
  }

  /// Submits a search query to the news controller.
  ///
  /// This method trims the provided keyword and passes it to the
  /// news controller to perform a search operation.
  ///
  /// @param keyword The search term to be submitted.
  /// @return A Future that completes when the search operation is finished.
  Future<void> submitSearch(String keyword) async {
    await newsController.searchNews(
      keyword.trim(),
      true,
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    focusNode.close();
    newsController.dispose();
    super.dispose();
  }
}
