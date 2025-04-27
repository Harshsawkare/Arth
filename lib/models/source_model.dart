import 'package:arth_ai/utils/constants.dart';
import 'package:hive/hive.dart';

part 'source_model.g.dart';

@HiveType(typeId: 2)
class Source {
  @HiveField(0)
  final String? sourceId;

  @HiveField(1)
  final String? sourceName;

  Source({this.sourceId, this.sourceName});

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    sourceId: json[Constants.sourceId],
    sourceName: json[Constants.sourceName],
  );

  Map<String, dynamic> toJson() => {
    Constants.sourceId: sourceId,
    Constants.sourceName: sourceName,
  };
}
