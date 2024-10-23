import 'package:hive_flutter/adapters.dart';
part 'language_model.g.dart';
@HiveType(typeId: 5)
class LanguageModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String language;

  LanguageModel(this.language, this.id);
}