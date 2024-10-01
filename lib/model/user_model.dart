import 'package:hive_flutter/adapters.dart';
part 'user_model.g.dart';
@HiveType(typeId: 3)
class UserModel {

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String image_path;

UserModel(this.id, this.username, this.image_path);

}