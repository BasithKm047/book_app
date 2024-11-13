import 'package:book_app/model/book_model.dart';
import 'package:book_app/util/book_card.dart';
import 'package:book_app/function/book_db_function.dart';
import 'package:book_app/util/common_function.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';

class LibraryDetailsScreen extends StatelessWidget {
  String name = '';

  final String title;

  LibraryDetailsScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    getAllBooks();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
            style: CostumFontStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white)
                .getFontstyle(),
            title),
      ),
      body: ValueListenableBuilder(
        valueListenable: bookListnotifier,
        builder: (context, bookList, child) {
          List<Book> filteredBooks = [];

          // Future<List<Book>> recentlyReadBooks = getRecentlyReadBooks(5);
          if (title == favourite) {
            filteredBooks = bookList.where((book) => book.isFavourite).toList();
          } else if (title == WantToRead) {
            filteredBooks =
                bookList.where((book) => book.isWantToRead).toList();
          } else if (title == Finished) {
            filteredBooks = bookList.where((book) => book.isFinished).toList();
          } else if (title == recent) {
            filteredBooks = getRecentlyReadBooks(bookList);
          } else if (title == newReleases) {
            filteredBooks = getNewAddedBooks(bookList);
          }

          if (filteredBooks.isEmpty) {
            String name = title == favourite
                ? "Favourite"
                : title == WantToRead
                    ? "Want to Read"
                    : title == Finished
                        ? "Finished"
                        : title == recent
                            ? "Recently Read"
                            : title==newReleases
                            ?'New Releases':'';
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  'The $name list is empty. Add a book to $name.',
                  style: CostumFontStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal)
                      .getFontstyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.50,
            ),
            itemBuilder: (context, index) {
              return BookCard(
                title: filteredBooks[index].bookName,
                isAdmin: false,
                imagePath: filteredBooks[index].image_path,
                isLanguage: false,
              );
            },
            itemCount: filteredBooks.length,
          );
        },
      ),
    );
  }
}
