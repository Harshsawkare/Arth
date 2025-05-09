import 'package:arth_ai/models/article_model.dart';
import 'package:arth_ai/services/connectivity_service.dart';
import 'package:arth_ai/utils/constants.dart';
import 'package:arth_ai/views/widgets/empty_image_widget.dart';
import 'package:arth_ai/views/widgets/news_details_webview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/news_controller.dart';
import '../utils/helper.dart';

/// A widget that displays detailed information about a news article.
///
/// This scaffold presents a comprehensive view of a news article including
/// its title, image, description, source information, publication date, and content.
/// It receives the article data through GetX arguments.
class NewsDetailsScaffold extends StatefulWidget {
  /// Creates a news details scaffold.
  ///
  /// The [key] parameter is optional and is passed to the parent class.
  const NewsDetailsScaffold({super.key});

  @override
  State<NewsDetailsScaffold> createState() => _NewsDetailsScaffoldState();
}

class _NewsDetailsScaffoldState extends State<NewsDetailsScaffold> {
  final newsController = Get.find<NewsController>();
  final connectivity = Get.find<ConnectivityService>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final article = Get.arguments as Article;
    final imageUrl = article.urlToImage ?? Constants.emptyImagePath;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            newsController.showWebView.value = false;
            Get.back();
          },
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Obx(() {
        return SizedBox(
          width: Get.width,
          height: Get.height,
          child: newsController.showWebView.value
              ? NewsDetailsWebView(
                  link: article.url ?? '',
                )
              : SingleChildScrollView(
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
                            tag: article.uniqueId ?? '',
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

                      /// source
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

                      /// view details
                      if (Helper.isValidUrl(article.url) &&
                          connectivity.isOnline.value)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  newsController.showWebView.value = true,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  Constants.viewDetails,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
        );
      }),
    );
  }
}
