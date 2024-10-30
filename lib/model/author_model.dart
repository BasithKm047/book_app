import 'package:hive_flutter/adapters.dart';
part 'author_model.g.dart';

@HiveType(typeId: 6)
class AuthorModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String image_path;
  AuthorModel(this.id, this.name, this.image_path);
    @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthorModel && runtimeType == other.runtimeType && id == other.id && name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

}