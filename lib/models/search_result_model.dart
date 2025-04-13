import 'package:hive/hive.dart';
import 'article_model.dart';

part 'search_result_model.g.dart';

@HiveType(typeId: 3)
class SearchResult extends HiveObject {
  @HiveField(0)
  final String keyword;

  @HiveField(1)
  final List<Article> articles;

  @HiveField(2)
  final DateTime timestamp;

  SearchResult({
    required this.keyword,
    required this.articles,
    required this.timestamp,
  });
}
