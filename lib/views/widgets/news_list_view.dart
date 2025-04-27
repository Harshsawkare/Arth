import 'package:arth_ai/utils/constants.dart';
import 'package:arth_ai/views/widgets/shimmer_article_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../controllers/news_controller.dart';
import 'article_tile.dart';

/// A widget that displays a scrollable list of news articles.
///
/// This widget uses GetX for state management and implements infinite scrolling
/// by loading more articles when the user scrolls near the bottom of the list.
class NewsListView extends StatefulWidget {
  /// Creates a news list view.
  ///
  /// The [key] parameter is optional and is passed to the parent class.
  const NewsListView({super.key});

  @override
  State<NewsListView> createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  /// Controller that manages the news articles data and loading state.
  final NewsController newsController = Get.find<NewsController>();

  /// Controller that manages the scrolling behavior of the list.
  ///
  /// Used to detect when the user has scrolled near the bottom to trigger loading more articles.
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    /// Sets up a listener to detect when the user scrolls near the bottom of the list.
    ///
    /// When the user scrolls within [Constants.maxPixelsCloseToBottom] pixels of the bottom, it triggers
    /// the [loadMore] method on the news controller to fetch additional articles.
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent -
              Constants.maxPixelsCloseToBottom) {
        newsController.loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() {
      if (newsController.isLoading.value && newsController.articles.isEmpty) {
        return Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Shimmer.fromColors(
              baseColor: theme.cardColor,
              highlightColor: theme.disabledColor,
              child: ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      const ShimmerArticlePlaceholder()),
            ),
          ),
        );
      }

      return Expanded(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              cacheExtent: 1000,
              controller: scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < newsController.articles.length) {
                        final article = newsController.articles[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ArticleTile(article: article),
                        );
                      }
                    },
                    childCount: newsController.articles.length + 1,
                  ),
                ),
              ],
            )),
      );
    });
  }

  /// Cleans up resources when the widget is removed from the widget tree.
  ///
  /// Disposes both the news controller and scroll controller to prevent memory leaks.
  @override
  void dispose() {
    newsController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
