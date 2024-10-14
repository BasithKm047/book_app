import 'package:hive_flutter/adapters.dart';
part 'genres_model.g.dart';

@HiveType(typeId: 2)
class GenresModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? image_path;

  GenresModel(
    this.id,  this.image_path,  {
    required this.name,
  });
}
