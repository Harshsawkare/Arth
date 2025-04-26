import 'package:arth_ai/utils/constants.dart';
import 'package:hive/hive.dart';

part 'source_model.g.dart';

@HiveType(typeId: 2)
class Source {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json[Constants.id],
    name: json[Constants.name],
  );

  Map<String, dynamic> toJson() => {
    Constants.id: id,
    Constants.name: name,
  };
}
