import 'package:hive/hive.dart';
part 'requested_book_model.g.dart';
@HiveType(typeId: 7)
class RequestedBookModel {
  @HiveField(0)

  int id;

  @HiveField(1)

  String bookName;

  RequestedBookModel({required this.id, required this.bookName});
}
