import 'package:hive_flutter/adapters.dart';
part 'book_model.g.dart';


@HiveType(typeId: 1)
class Book {

  @HiveField(0)
  final String imagePath;
  @HiveField(1)
  final String  bookName;
  @HiveField(2)
  final String  discribtion;

  Book( this.imagePath, this.bookName, this.discribtion);


}