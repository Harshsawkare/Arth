import 'package:arth_ai/controllers/search_controller.dart';
import 'package:arth_ai/services/local_db_repository.dart';
import 'package:arth_ai/utils/constants.dart';
import 'package:arth_ai/views/widgets/news_list_view.dart';
import 'package:arth_ai/views/widgets/search_bar.dart';
import 'package:arth_ai/views/widgets/search_history_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/news_controller.dart';
import '../controllers/theme_controller.dart';

/// A stateful widget that represents the main home screen of the application.
///
/// This widget displays the app's main interface including:
/// - App bar with theme toggle functionality
/// - Search box for news queries
/// - Search history chips for quick access to previous searches
/// - News list or empty state placeholder
class HomeScaffold extends StatefulWidget {
  /// Creates a [HomeScaffold] widget.
  ///
  /// The [key] parameter is optional and is passed to the parent class.
  const HomeScaffold({super.key});

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  /// Repository for accessing locally stored data like search history.
  final LocalDbRepository localDbRepository = LocalDbRepository();
  
  /// Controller for managing news data and operations.
  final NewsController newsController = Get.find<NewsController>();
  
  /// Controller for managing theme-related operations.
  final ThemeController themeController = Get.find<ThemeController>();
  
  /// Controller for managing search box state and operations.
  final SearchBoxController searchBoxController = Get.find<SearchBoxController>();
  
  /// Builds the widget tree for the home screen.
  ///
  /// This method constructs the UI for the home screen including the app bar,
  /// search functionality, search history chips, and news content or empty state.
  ///
  /// [context] The build context for this widget.
  ///
  /// Returns a [Scaffold] widget containing the complete home screen UI.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          surfaceTintColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: false,
          title: Text(
            Constants.appName,
            style: theme.textTheme.headlineMedium,
          ),
          actions: [
            Obx(() {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () {
                    themeController.toggleTheme();
                  },
                  child: themeController.isDarkMode.value
                      ? Icon(
                          Icons.light_mode_rounded,
                          color: theme.iconTheme.color,
                          size: theme.iconTheme.size,
                        )
                      : Icon(
                          Icons.dark_mode_rounded,
                          color: theme.iconTheme.color,
                          size: theme.iconTheme.size,
                        ),
                ),
              );
            }),
          ]),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          searchBoxController.focusNode.value.unfocus();
          searchBoxController.isActive.value = false;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchBox(),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              localDbRepository.getSavedKeywords().length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final searchHistory =
                                localDbRepository.getSavedKeywords();

                            return SearchHistoryChip(
                                keyword: searchHistory[index]);
                          }),
                    ),
                  ),
                  if (!newsController.isLoading.value &&
                      newsController.articles.isEmpty) ...[
                    const Spacer(),
                    Image.asset(
                      'assets/empty_list_text.png',
                      width: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        Constants.emptyListMessage,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.iconTheme.color,
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                  NewsListView()
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  /// Cleans up resources when this widget is removed from the widget tree.
  ///
  /// This method ensures proper disposal of controllers to prevent memory leaks.
  @override
  void dispose() {
    newsController.dispose();
    themeController.dispose();
    super.dispose();
  }
}
