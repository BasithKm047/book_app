import 'dart:io';

import 'package:book_app/Admin/details_updating_screen.dart';
import 'package:book_app/function/author_db_function.dart';
import 'package:book_app/function/genres_db_function.dart';
import 'package:book_app/function/language_db_function.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/util/costum_bookview_screen.dart';
import 'package:book_app/function/book_db_function.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:book_app/util/common_function.dart';

// ignore: must_be_immutable
class BookCard extends StatefulWidget {
  final bool isLanguage;
  String title;
  String imagePath;
  Icon? icon;
  Icon? icon_2;
  final bool isAdmin;
  BookCard(
      {super.key,
      required this.title,
      required this.imagePath,
      this.icon,
      this.icon_2,
      required this.isAdmin,
      required this.isLanguage});

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SizedBox(
            height: ResponsiveHelper(context).getResponsiveHeight(22),
            width: ResponsiveHelper(context).getResponsiveWidth(50),
            // color: Colors.amber,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CostumBookviewScreen(
                      name: widget.title,
                    ),
                  ));
                },
                child: Image.file(
                  File(widget.imagePath),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          Container(
              height: ResponsiveHelper(context).getResponsiveHeight(6),
              width: ResponsiveHelper(context).getResponsiveWidth(48),
              decoration: BoxDecoration(
                  color: CostumColor().costum_color_3,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                    style: GoogleFonts.lora(
                      // fontSize: ,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    widget.title),
              )),

          ValueListenableBuilder(
            valueListenable: bookListnotifier,
            builder: (context, value, child) {
              final bookDetails = value.firstWhere(
                (val) => val.bookName == widget.title,
                orElse: () => Book(
                    id: 1,
                    image_path: '',
                    bookName: '',
                    discribtion: '',
                    pdf_path: '',
                    genre: genremodelList.value.first,
                    language: languageModelList.value.first,
                    authors: author_modelList.value.first,
                    isFavourite: false,
                    isWantToRead: false,
                    isFinished: false),
              );
              double progress = (bookDetails.currentPage /
                      (bookDetails.totalPage > 0 ? bookDetails.totalPage : 1))
                  .clamp(0.0, 1.0);
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(5),
                    value: progress,
                    backgroundColor: Colors.white,
                    color: Colors.blue,
                  ),
                  Text(
                    
                    '${(progress * 100).toStringAsFixed(1)}%',
                    style: const TextStyle(fontSize: 13, color: Colors.white),
                  ),
                ],
              );
            },
          ),

          if (widget.isAdmin == true)
            ValueListenableBuilder(
              valueListenable: bookListnotifier,
              builder: (context, value, child) {
                final bookDetails = value.firstWhere(
                  (val) => val.bookName == widget.title,
                  orElse: () => Book(
                      id: 1,
                      bookName: '',
                      discribtion: '',
                      image_path: '',
                      pdf_path: '',
                      genre: genremodelList.value.first,
                      language: languageModelList.value.first,
                      authors: author_modelList.value.first,
                      isFavourite: false,
                      isWantToRead: false,
                      isFinished: false,
                      readingTimeInsecond: 0),
                );

                // if(bookDetails==null){
                //   return const SizedBox.shrink();
                // }
                return Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.icon != null
                          ? IconButton(
                              onPressed: () {
                                //delete the book
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return alertDialogForDelete(
                                        context: context,
                                        itemDetails: bookDetails,
                                        itemType: bookDetails.bookName,
                                        deleteFunction: deleteBooks);
                                  },
                                );
                              },
                              icon: Icon(
                                  // size: 23,
                                  color: const Color.fromARGB(255, 228, 45, 32),
                                  widget.icon!.icon))
                          : const SizedBox.shrink(),
                      widget.icon_2 != null
                          ? IconButton(
                              onPressed: () {
                                //edit the book
                                // widget.onUpdate;
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DetailsUpdatingScreen(
                                    bookDetails: bookDetails,
                                  ),
                                ));
                              },
                              icon: Icon(
                                  // size: 23,
                                  color: CostumColor().costum_color_1,
                                  widget.icon_2!.icon),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                );
              },
            ),

          // Icon(Icons.abc_sharp),
        ],
      ),
    );
  }

  // Define a generic alert dialog for deletion that accepts a callback function and an item to delete
}
