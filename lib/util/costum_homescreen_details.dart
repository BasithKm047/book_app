import 'dart:convert';
import 'dart:io';

import 'package:book_app/util/catogories_screen.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/util/common_function.dart';
import 'package:book_app/util/costum_bookview_screen.dart';
import 'package:book_app/function/book_db_function.dart';
import 'package:book_app/function/genres_db_function.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CostumHomescreenDetails extends StatelessWidget {
  final String title;
  // final String imagePath;
  final bool isAdmin;
  // final GenresModel genres;
  const CostumHomescreenDetails({
    super.key,
    required this.title,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    getAllBooks();
    getAllGenres();
    getBooksByGenre;
    return Container(
      height: ResponsiveHelper(context).getResponsiveHeight(50),
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: CostumColor().costum_color_4,
            offset: const Offset(-3, 3),
            blurRadius: 10,
            // spreadRadius: 3,
          )
        ],
        color: CostumColor().costum_color_4,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CatogoriesScreen(
                        title: title,
                        isAdmin: isAdmin,
                        isLanguage: false,
                        isAUthor: false,
                        isGenre: true,
                      ),
                    ));
                  },
                  child: Text(
                      style: CostumFontStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: CostumColor().costum_color_1)
                          .getFontstyle(),
                      title),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CatogoriesScreen(
                        title: title,
                        isAdmin: isAdmin,
                        isLanguage: false,
                        isAUthor: false,
                        isGenre: true,
                      ),
                    ));
                  },
                  icon: Icon(
                      size: 13,
                      color: CostumColor().costum_color_1,
                      Icons.arrow_forward_ios_outlined))
            ],
          ),
          SizedBox(
            height: ResponsiveHelper(context).getResponsiveHeight(30),
            // width: ResponsiveHelper(context).getResponsiveWidth(46),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8),
              child: ValueListenableBuilder(
                  valueListenable: bookListnotifier,
                  builder: (context, value, child) {
                    List<Book> filterBooks = [];

                    if (title == WantToRead) {
                      filterBooks =
                          value.where((book) => book.isWantToRead).toList();
                    } else if (title == recent) {
                      filterBooks = getRecentlyReadBooks(value);
                    } else if (title == newReleases) {
                      filterBooks = getNewAddedBooks(value);
                    }

                    return ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 10,
                            ),
                        scrollDirection: Axis.horizontal,
                        // scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 10,
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          CostumBookviewScreen(
                                              name:
                                                  filterBooks[index].bookName),
                                    ));
                                  },
                                  child: kIsWeb
                                      ? Image.memory(
                                          base64Decode(filterBooks[index]
                                              .image_path), // Decode Base64 for Web
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          File(filterBooks[index]
                                              .image_path), // File path for Mobile
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: filterBooks.length);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
