import 'package:book_app/model/author_model.dart';
import 'package:book_app/model/genres_model.dart';
import 'package:book_app/model/language_model.dart';
import 'package:hive_flutter/adapters.dart';
part 'book_model.g.dart';


@HiveType(typeId: 1)
class Book {

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String image_path;
  @HiveField(2)
  final String  bookName;
  @HiveField(3)
   AuthorModel authors;
  @HiveField(4)
  final String  discribtion;
  @HiveField(5)
  final String pdf_path;
  @HiveField(6)
  final GenresModel genre;
  @HiveField(7)
  LanguageModel language;
  

  Book(this.id, this.image_path, this.bookName, this.discribtion, this.pdf_path, this.genre,this.language,this.authors);


}