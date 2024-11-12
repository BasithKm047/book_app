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
  @HiveField(8)
  bool isFavourite;
  @HiveField(9)
  bool isWantToRead;
  @HiveField(10)
  bool isFinished;
  @HiveField(11)
  DateTime? lastRead;
  @HiveField(12)
  int totalPage;
  @HiveField(13)
  int currentPage;
  @HiveField(14)
  DateTime ?newAdded;
  @HiveField(15)
   bool isNewReleases;
  @HiveField(16)
  int targetTimeInsecond=300;
  @HiveField(17)
  int readingTimeInsecond;
  
  

  Book({required this.id,required this.image_path,required this.bookName,required this.discribtion,required this.pdf_path,required this.genre,required this.language,required this.authors,required this.isFavourite,required this.isWantToRead,required this.isFinished, this.lastRead, this.totalPage=0,this.currentPage=0,this.newAdded, this.isNewReleases=true, this.readingTimeInsecond=0});

  


}