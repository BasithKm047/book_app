import 'package:book_app/model/requested_book_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

ValueNotifier <List<RequestedBookModel>>requestBookList=ValueNotifier([]);

String requestBookDbName='requestbook';
  
Future<void>addRequestedBook(RequestedBookModel requestBook)async{
  final requestBookDb=await Hive.openBox<RequestedBookModel>(requestBookDbName);
   requestBookDb.put(requestBook.id, requestBook);
   print('RequestedBook added Successfully');
   requestBookList.notifyListeners();

}

Future<List<RequestedBookModel>>getRequestedBooks()async{
  final requestedBookDb=await Hive.openBox<RequestedBookModel>(requestBookDbName);
  final getRequestedBooks=requestedBookDb.values.toList();
  requestBookList.value=getRequestedBooks;
  print('Requested Book loaded: ${getRequestedBooks.map((g) => g.bookName).toList()}');
  requestBookList.notifyListeners();
  return getRequestedBooks;
}

Future<void>deleteRequestedBook(RequestedBookModel requestBook)async{
  final RequestBookDb=await Hive.openBox<RequestedBookModel>(requestBookDbName);
  await RequestBookDb.delete(requestBook.id);
   print('deleted succesfully');
   getRequestedBooks();



}