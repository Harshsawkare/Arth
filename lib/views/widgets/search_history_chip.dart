import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/news_controller.dart';
import '../../controllers/search_controller.dart';

/// A widget that displays a search history keyword as a chip.
///
/// This widget creates a tappable chip that represents a previously searched keyword.
/// When tapped, it sets the search controller's text to the keyword and triggers
/// a news search with that keyword.
class SearchHistoryChip extends StatefulWidget {
  /// The search keyword to display in the chip.
  final String keyword;

  /// Creates a [SearchHistoryChip].
  ///
  /// The [keyword] parameter is required and represents the search term to be displayed.
  const SearchHistoryChip({super.key, required this.keyword});

  @override
  State<SearchHistoryChip> createState() => _SearchHistoryChipState();
}

class _SearchHistoryChipState extends State<SearchHistoryChip> {
  final NewsController newsController = Get.find<NewsController>();
  final SearchBoxController searchController = Get.find<SearchBoxController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () async {
          searchController.searchController.text = widget.keyword;
          FocusScope.of(context).unfocus();
          return newsController.searchNews(
            widget.keyword,
            true,
            showInternetSnackbar: false,
          );
        },
        child: Chip(
          label: Text(
            widget.keyword,
          ),
          backgroundColor: theme.scaffoldBackgroundColor,
          side: BorderSide(
            color: newsController.searchQuery.value == widget.keyword
                ? theme.primaryColor
                : theme.disabledColor,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  /// Disposes of the controllers when this widget is removed from the widget tree.
  ///
  /// This method ensures that resources used by the controllers are properly released.
  @override
  void dispose() {
    newsController.dispose();
    searchController.dispose();
    super.dispose();
  }
}
