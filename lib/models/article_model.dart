import 'package:arth_ai/models/source_model.dart';
import 'package:arth_ai/utils/constants.dart';
import 'package:arth_ai/utils/helper.dart';
import 'package:hive/hive.dart';

part 'article_model.g.dart';

@HiveType(typeId: 1)
class Article {
  @HiveField(0)
  final Source? source;

  @HiveField(1)
  final List? creator;

  @HiveField(2)
  final String? title;

  @HiveField(3)
  final String? description;

  @HiveField(4)
  final String? link;

  @HiveField(5)
  final String? imageUrl;

  @HiveField(6)
  final String? pubDate;

  @HiveField(7)
  final String? articleId;

  Article({
    this.source,
    this.creator,
    this.title,
    this.description,
    this.link,
    this.imageUrl,
    this.pubDate,
    this.articleId,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: json[Constants.sourceName] != null
            ? Source.fromJson({
                Constants.sourceId: json[Constants.sourceId],
                Constants.sourceName: json[Constants.sourceName],
              })
            : null,
        creator: json[Constants.creator],
        title: json[Constants.title],
        description: json[Constants.description],
        link: json[Constants.link],
        imageUrl: json[Constants.imageUrl],
        pubDate: json[Constants.pubDate],
        articleId: json[Constants.articleId],
      );

  Map<String, dynamic> toJson() => {
        Constants.source: source?.toJson(),
        Constants.creator: creator,
        Constants.title: title,
        Constants.description: description,
        Constants.link: link,
        Constants.imageUrl: imageUrl,
        Constants.pubDate: pubDate,
        Constants.articleId: articleId,
      };
}
