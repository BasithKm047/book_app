import 'dart:io';

import 'package:book_app/User/book_reader_screen.dart';
import 'package:book_app/function/book_db_function.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/material.dart';

class CostumBookviewScreen extends StatefulWidget {
  final String name;

  const CostumBookviewScreen({
    super.key,
    required this.name,
  });

  @override
  State<CostumBookviewScreen> createState() => _CostumBookviewScreenState();
}

class _CostumBookviewScreenState extends State<CostumBookviewScreen> {
  var isFavourite = false;
  var isWantToRead = false;
  var isAdd = false;
  var isFinished = false;
  ValueNotifier<List<Book>> favouriteBooks = ValueNotifier([]);
  ValueNotifier<List<Book>> WantToReadsBooks = ValueNotifier([]);
  ValueNotifier<List<Book>> finishedBooks = ValueNotifier([]);
  ValueNotifier <List<Book>>recentlyReadBooks=ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
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
            widget.name),
      ),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: bookListnotifier,
          builder: (context, bookList, child) {
            final bookDetails = bookList.firstWhere(
              (book) => book.bookName == widget.name,
            );
            isFavourite = bookDetails.isFavourite;
            isWantToRead = bookDetails.isWantToRead;
            isFinished=bookDetails.isFinished;

            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: ResponsiveHelper(context).getResponsiveHeight(30),
                    width: ResponsiveHelper(context).getResponsiveWidth(40),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                            fit: BoxFit.cover, File(bookDetails.image_path)),
                      ),
                    ),
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buttons(() => addtoFav(bookDetails), isFavourite),
                      const SizedBox(
                        width: 10,
                      ),
                      // buttons('Want to Read', () => addtoWantToRead(bookDetails),isWantToRead),
                      popMenuButton(bookDetails)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: ResponsiveHelper(context).getResponsiveHeight(37),
                    width: ResponsiveHelper(context).getResponsiveWidth(80),
                    decoration: BoxDecoration(
                        color: CostumColor().costum_color_4,
                        borderRadius: BorderRadius.circular(10)),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          textforBook('Book name:', bookDetails.bookName),
                          // const SizedBox(height: 20,),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(),
                          ),
                          textforBook('Author name:', bookDetails.authors.name),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(),
                          ),

                          textforBook('Discribtion:', bookDetails.discribtion),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: ResponsiveHelper(context).getResponsiveWidth(80),
                    decoration: const BoxDecoration(),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CostumColor().costum_color_4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        setState(() {
                          bookDetails.lastRead=DateTime.now();
                          recentlyReadBook(bookDetails);
                        });
                        bookListnotifier.notifyListeners();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BookReaderScreen(
                            pdf_path: bookDetails.pdf_path,
                          ),
                        ));
                      },
                      child: Text(
                          style: CostumFontStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal)
                              .getFontstyle(),
                          'Read'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  PopupMenuButton<String> popMenuButton(Book book) {
    return PopupMenuButton<String>(
      color: CostumColor().costum_color_3,
      icon: Icon(
        Icons.more_vert,
        color: CostumColor().costum_color_1,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem<String>(
              value: 'Want to Read',
              child: Text(
                isWantToRead ? 'Remove from Want to Read' : 'Want to Read',
                style: CostumFontStyle(
                        color: CostumColor().costum_color_1,
                        fontSize: 15,
                        fontWeight: FontWeight.normal)
                    .getFontstyle(),
              )),
          PopupMenuItem<String>(
              value: 'Finished',
              child: Text(
                isFinished ? 'Remove from Finished' : 'Mark as Finished',
                style: CostumFontStyle(
                        color: CostumColor().costum_color_1,
                        fontSize: 15,
                        fontWeight: FontWeight.normal)
                    .getFontstyle(),
              ))
        ];
      },
      onSelected: (value) {
        if (value == 'Want to Read') {
          addtoWantToRead(book);
        } else if (value == 'Finished') {
          finishedBook(book);
        }
      },
    );
  }

  Widget buttons(VoidCallback onTap, bool isActive) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            onTap();
          },
          icon: isActive
              ? const Icon(color: Colors.red, Icons.favorite)
              : const Icon(color: Colors.red, Icons.favorite_border),
        ),
        const SizedBox(
          width: 10,
        ),
        const SizedBox(
          width: 5,
        ),
      ],
    );
  }

  Widget textforBook(String bookDetails1, String bookDetails2) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 10,
        ),
        Text(
            style: CostumFontStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal)
                .getFontstyle(),
            bookDetails1),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Text(
            style: CostumFontStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal)
                .getFontstyle(),
            bookDetails2,
            overflow: TextOverflow.visible,
          ),
        )
      ],
    );
  }

  Future<void> addtoFav(Book book) async {
    setState(() {
      isFavourite = !isFavourite;
      book.isFavourite = !book.isFavourite;
      if (book.isFavourite) {
        favouriteBooks.value.add(book);
      } else {
        favouriteBooks.value.remove(book);
      }
    });
     bookListnotifier.notifyListeners();
  }

  Future<void> addtoWantToRead(Book book) async {
    setState(() {
      isWantToRead = !isWantToRead;
      book.isWantToRead = !book.isWantToRead;
      if (isWantToRead) {
        WantToReadsBooks.value.add(book);
      } else {
        WantToReadsBooks.value.remove(book);
      }
    });
     bookListnotifier.notifyListeners();
  }

  Future<void> finishedBook(Book book) async {
    setState(() {
      isFinished = !isFinished;
      book.isFinished = !book.isFinished;
      if (isFinished) {
        finishedBooks.value.add(book);
      } else {
        finishedBooks.value.remove(book);
      }
    });
    bookListnotifier.notifyListeners(); 
  }
  void recentlyReadBook(Book bookDetails){
    setState(() {
      if(!recentlyReadBooks.value.contains(bookDetails)){
        recentlyReadBooks.value.add(bookDetails);
      }
    });
    bookListnotifier.notifyListeners();
  }
}
