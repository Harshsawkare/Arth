import 'package:arth_ai/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arth_ai/controllers/search_controller.dart';

/// A customizable search box widget that provides search functionality.
///
/// This widget creates a search input field with dynamic icons that change based on
/// the search state. It uses GetX for state management and provides visual feedback
/// for active/inactive states.
class SearchBox extends StatefulWidget {
  /// Creates a search box widget.
  ///
  /// The [key] parameter is optional and is used to control how one widget replaces
  /// another widget in the tree.
  SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  /// Controller that manages the search box state and functionality.
  ///
  /// This controller handles search text, focus state, and search submission logic.
  final SearchBoxController searchController = Get.find<SearchBoxController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.brightness == Brightness.dark
                ? Colors.grey.shade800
                : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: searchController.isActive.value
                  ? GestureDetector(
                      onTap: searchController.clearSearch,
                      child: Icon(
                        Icons.close,
                        color: theme.iconTheme.color,
                        size: theme.iconTheme.size,
                      ),
                    )
                  : Icon(
                      Icons.search,
                      color: theme.iconTheme.color,
                      size: theme.iconTheme.size,
                    ),
            ),
            Expanded(
              child: TextField(
                focusNode: searchController.focusNode.value,
                controller: searchController.searchController,
                onChanged: (val) => searchController.searchText.value = val,
                onSubmitted: (val) => searchController
                    .submitSearch(searchController.searchText.value),
                onTap: searchController.activate,
                cursorColor: theme.primaryColor,
                style: theme.textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: Constants.searchHint,
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.iconTheme.color,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            if (searchController.isActive.value)
              GestureDetector(
                onTap: () async => searchController
                    .submitSearch(searchController.searchText.value),
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: theme.iconTheme.color,
                  size: 26,
                ),
              ),
          ],
        ),
      );
    });
  }

  /// Disposes resources used by the search box.
  ///
  /// This method ensures proper cleanup of the search controller when
  /// the widget is removed from the widget tree.
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
