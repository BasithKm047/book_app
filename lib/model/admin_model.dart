import 'package:hive_flutter/adapters.dart';
part 'admin_model.g.dart';

@HiveType(typeId: 4)
class AdminModel {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String image_path;

  

  // ignore: non_constant_identifier_names
  AdminModel({required this.id, required this.name, this.image_path=''});
}
