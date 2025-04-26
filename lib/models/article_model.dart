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
  final String? author;

  @HiveField(2)
  final String? title;

  @HiveField(3)
  final String? description;

  @HiveField(4)
  final String? url;

  @HiveField(5)
  final String? urlToImage;

  @HiveField(6)
  final String? publishedAt;

  @HiveField(7)
  final String? content;

  @HiveField(8)
  final String uniqueId;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    String? uniqueId,
  }) : uniqueId = uniqueId ?? Helper.generateUniqueId();

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    source: json[Constants.source] != null
        ? Source.fromJson(json[Constants.source])
        : null,
    author: json[Constants.author],
    title: json[Constants.title],
    description: json[Constants.description],
    url: json[Constants.url],
    urlToImage: json[Constants.urlToImage],
    publishedAt: json[Constants.publishedAt],
    content: json[Constants.content],
    uniqueId: json[Constants.uniqueId],
  );

  Map<String, dynamic> toJson() => {
    Constants.source: source?.toJson(),
    Constants.author: author,
    Constants.title: title,
    Constants.description: description,
    Constants.url: url,
    Constants.urlToImage: urlToImage,
    Constants.publishedAt: publishedAt,
    Constants.content: content,
    Constants.uniqueId: uniqueId,
  };
}