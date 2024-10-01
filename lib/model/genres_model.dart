import 'package:hive_flutter/adapters.dart';
part 'genres_model.g.dart';

@HiveType(typeId: 2)
class GenresModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  final String name;

  GenresModel(
    this.id, {
    required this.name,
  });
}
