import 'package:arth_ai/models/article_model.dart';
import 'package:arth_ai/utils/constants.dart';
import 'package:arth_ai/utils/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'empty_image_widget.dart';

/// A widget that displays a news article in a card-like tile format.
///
/// This widget renders an article with its image, title, description, source,
/// and publication date in a visually appealing card layout. When tapped,
/// it navigates to the detailed view of the article.
class ArticleTile extends StatelessWidget {
  /// The article data to be displayed in the tile.
  ///
  /// Contains information such as title, description, image URL, source,
  /// and publication date.
  final Article article;

  /// Creates an [ArticleTile] widget.
  ///
  /// The [article] parameter is required and contains all the data
  /// needed to display the article information.
  const ArticleTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl = article.imageUrl ?? Constants.emptyImagePath;
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Constants.newsDetailsScreen,
          arguments: article,
        );
      },
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: theme.brightness == Brightness.light
                  ? Colors.grey.shade200
                  : Colors.grey.shade900,
              offset: const Offset(3, 3),
              blurRadius: 7,
            ),
          ],
        ),
        child: Column(
          children: [
            /// Image
            SizedBox(
              height: 150,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
                child: Hero(
                  tag: article.articleId ?? '',
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

            /// Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      article.title ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      article.description ?? '',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.highlightColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Divider(thickness: 0.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          article.source?.sourceName ?? '',
                          style: theme.textTheme.bodySmall,
                        ),
                        const Spacer(),
                        Text(
                          Helper.formatDateTime(article.pubDate ?? ''),
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
