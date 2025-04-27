import 'package:arth_ai/models/article_model.dart';
import 'package:arth_ai/utils/constants.dart';
import 'package:arth_ai/views/widgets/empty_image_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/helper.dart';

/// A widget that displays detailed information about a news article.
///
/// This scaffold presents a comprehensive view of a news article including
/// its title, image, description, source information, publication date, and content.
/// It receives the article data through GetX arguments.
class NewsDetailsScaffold extends StatelessWidget {
  /// Creates a news details scaffold.
  ///
  /// The [key] parameter is optional and is passed to the parent class.
  const NewsDetailsScaffold({super.key});

  @override

  /// Builds the UI for the news article details screen.
  ///
  /// This method constructs a scrollable layout that displays all components
  /// of the article in a structured format. It uses the current theme for styling
  /// and retrieves the article data from GetX arguments.
  ///
  /// [context] The build context, providing access to the theme and other
  /// inherited widgets.
  ///
  /// Returns a [Widget] representing the complete news details screen.
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final article = Get.arguments as Article;
    final imageUrl = article.urlToImage ?? Constants.emptyImagePath;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  article.title ?? '',
                  style: theme.textTheme.headlineMedium,
                ),
              ),

              /// image
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 150,
                  ),
                  child: Hero(
                    tag: article.uniqueId,
                    child: CachedNetworkImage(
                      width: double.infinity,
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const EmptyImageWidget(),
                    ),
                  ),
                ),
              ),

              /// description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  article.description ?? '',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.highlightColor,
                  ),
                ),
              ),

              /// source
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 2,
                ),
                child: Divider(
                  thickness: 0.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      article.source?.name ?? '',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.primaryColor,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      Helper.formatDateTime(article.publishedAt ?? ''),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 2,
                ),
                child: Divider(
                  thickness: 0.5,
                ),
              ),

              /// content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  article.content ?? '',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.highlightColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
