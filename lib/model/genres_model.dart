

import 'package:book_app/model/book_model.dart';
import 'package:hive_flutter/adapters.dart';
part 'genres_model.g.dart';

@HiveType(typeId: 2)
class GenresModel {

  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<Book>books;

  GenresModel({required this.name,required this.books});


}