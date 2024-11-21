import 'package:book_app/model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<Book>> bookListnotifier = ValueNotifier([]);
ValueNotifier<List<Book>> bookListbyGenreNotifier = ValueNotifier([]);
ValueNotifier<List<Book>> bookListByLanguage = ValueNotifier([]);
ValueNotifier<List<Book>> bookListbyAuthor = ValueNotifier([]);
ValueNotifier<List<Book>> recentlyReadBook = ValueNotifier([]);
ValueNotifier<List<Book>> newAddedBook = ValueNotifier([]);




Future<void> addBook(Book value) async {
  final bookDb = await Hive.openBox<Book>('books');
  await bookDb.put(value.id, value);
  print('Book added Successfully');
  bookListnotifier.value = bookDb.values.toList();
  bookListnotifier.notifyListeners();
}

Future<void> updateBook(Book value) async {
  final bookDb = await Hive.openBox<Book>('books');
  if (bookDb.containsKey(value.id)) {
    await bookDb.put(value.id, value);
  }
  print('Book Updated Successfully');
  getAllBooks();
  getBooksByGenre(value.genre.name);
  bookListnotifier.value = bookDb.values.toList();
  bookListnotifier.notifyListeners();
}

Future<void> deleteBooks(Book value) async {
  final bookDb = await Hive.openBox<Book>('books');
  if (bookDb.containsKey(value.id)) {
    await bookDb.delete(value.id);
  }
  print('Book deleted successfully');
  getAllBooks();
  getBooksByGenre(value.genre.name);
  getBookByAuthor(value.authors.name);
  getBookByLanguage(value.language.language);
  bookListnotifier.notifyListeners();
}

Future<void> getAllBooks() async {
  final bookdb = await Hive.openBox<Book>('books');
  final bookList = bookdb.values.toList();
  //  print('Book loaded: ${bookList.map((g) => g).toList()}');
  bookListnotifier.value = bookList;

  bookListnotifier.notifyListeners();
}

Future<List<Book>> getBooksByGenre(String genreName) async {
  final bookDb = Hive.box<Book>('books');

  // Print the available books and their genres for debugging
  final allBooks = bookDb.values.toList();
  print(
      'Available books: ${allBooks.map((book) => '${book.bookName} - Genre:  ${book.genre.name}').join(', ')}');

  print('Filtering books by genre: $genreName');

  // Filter books by genre
  final getBooksByGenre = allBooks
      .where((book) =>
          book.genre.name.trim().toLowerCase() ==
          genreName.trim().toLowerCase())
      .toSet()
      .toList();

  // Log the filtered results
  print('Books by $genreName: ${getBooksByGenre.map((book) => book.bookName)}');

  // Update the notifier and return the filtered list
  bookListbyGenreNotifier.value = getBooksByGenre;
  bookListbyGenreNotifier.notifyListeners();

  return getBooksByGenre;
}

Future<List<Book>> getBookByLanguage(String language) async {
  final bookDb = Hive.box<Book>('books');
  final bookListbyLanguage = bookDb.values
      .where((book) => book.language.language == language)
      .toSet()
      .toList();
  bookListByLanguage.value = bookListbyLanguage;
  bookListByLanguage.notifyListeners();
  print(
      'Books by $language: ${bookListbyLanguage.map((book) => book.bookName).toList()}');
  return bookListbyLanguage;
}

Future<List<Book>> getBookByAuthor(String author) async {
  final bookDb = Hive.box<Book>('books');
  final booksByauthor = bookDb.values
      .where((book) => book.authors.name == author)
      .toSet()
      .toList();
  bookListbyAuthor.value = booksByauthor;
  bookListbyAuthor.notifyListeners();
  print(
      'Books by$author:  ${booksByauthor.map((book) => book.bookName).toList()}');
  return booksByauthor;
}

Future<List<Book>> getFavouriteBooks() async {
  final bookDb = await Hive.openBox<Book>('books');
  final favouriteBooks =
      bookDb.values.where((book) => book.isFavourite).toList();
  bookListnotifier.value = favouriteBooks;
  bookListnotifier.notifyListeners();
  print(
      'Favorite Books: ${favouriteBooks.map((book) => book.bookName).toList()}');
  return favouriteBooks;
}

Future<void> recentlyReadBookFunction(Book book) async {
  final bookdb = await Hive.openBox<Book>('books');
  if (bookdb.containsKey(book.id)) {
    Book existingBook = bookdb.get(book.id)!;
    existingBook.lastRead = DateTime.now();
    await bookdb.put(book.id, existingBook);
  } else {
    await bookdb.put(book.id, book);
  }
  bookListnotifier.notifyListeners();
}

List<Book> getRecentlyReadBooks(List<Book> book) {
  List<Book> bookWithLastread =
      book.where((book) => book.lastRead != null).toList();
  bookWithLastread.sort((a, b) => b.lastRead!.compareTo(a.lastRead!));
  return bookWithLastread.take(5).toList();
  recentlyReadBook.value = bookWithLastread;
  recentlyReadBook.notifyListeners();
}

Future<void> newAddedBooks(Book book) async {
  // Check if the box is already open
  final bookDb = Hive.isBoxOpen('books')
      ? Hive.box<Book>('books')
      : await Hive.openBox<Book>('books');

  if (bookDb.containsKey(book.id)) {
    Book existingBook = bookDb.get(book.id) ?? book;
    existingBook.newAdded = DateTime.now();
    existingBook.isNewReleases = true;
    await bookDb.put(book.id, existingBook);
  } else {
    book.newAdded = DateTime.now();
    await bookDb.put(book.id, book);
  }

  bookListnotifier.notifyListeners();
}

List<Book> getNewAddedBooks(List<Book> books) {
  // Filter books that have a non-null 'newAdded' field
  List<Book> bookNewAdded =
      books.where((book) => book.isNewReleases == true).toList();

  // Sort books by 'newAdded' in descending order (most recent first)
  bookNewAdded.sort((a, b) => b.newAdded!
      .compareTo(a.newAdded!)); // Ensure latest added books appear first

  // Notify listeners for the new added books
  newAddedBook.value = bookNewAdded;
  newAddedBook
      .notifyListeners(); // This makes sure the UI updates with the new releases list

  // Return the top 10 most recent added books
  return bookNewAdded.take(5).toList();
}
