import 'package:book_app/model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<Book>> bookListnotifier = ValueNotifier([]);
ValueNotifier<List<Book>> bookListbyGenreNotifier = ValueNotifier([]);
ValueNotifier<List<Book>> bookListbyLanguage = ValueNotifier([]);

Future<void> addBook(Book value) async {
  final bookDb = await Hive.openBox<Book>('books');
  await bookDb.put(value.id, value);
  print('Book added Successfully');
}

Future<void> updateBook(Book value) async {
  final bookDb = await Hive.openBox<Book>('books');
  if (bookDb.containsKey(value.id)) {
    await bookDb.put(value.id, value);
  }
  print('Book Updated Successfully');
  getAllBooks();
  getBooksByGenre(value.genre.name);
}

Future<void> deleteBooks(Book value) async {
  final bookDb = await Hive.openBox<Book>('books');
  if (bookDb.containsKey(value.id)) {
    await bookDb.delete(value.id);
  }
  print('Book deleted successfully');
  getAllBooks();
  getBooksByGenre(value.genre.name);
}

Future<void> getAllBooks() async {
  final bookdb = await Hive.openBox<Book>('books');
  final bookList = bookdb.values.toList();
  //  print('Book loaded: ${bookList.map((g) => g).toList()}');
  bookListnotifier.value = bookList;

  bookListnotifier.notifyListeners();
}

Future<List<Book>> getBooksByGenre(String genreName) async {
  final bookListbyGenre = Hive.box<Book>('books');
  return bookListbyGenreNotifier.value = bookListbyGenre.values
      .where((book) => book.genre.name == genreName)
      .toList();
}

Future<List<Book>> getBookByLanguage(String language) async {
  final bookListbyLanguage = Hive.box<Book>('books');
  return bookListbyGenreNotifier.value = bookListbyLanguage.values
      .where((book) => book.language.language == language)
      .toList();
}
