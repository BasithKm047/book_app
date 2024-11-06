import 'dart:io';

import 'package:book_app/util/costum_bookview_screen.dart';
import 'package:book_app/util/costum_homescreen_details.dart';
import 'package:book_app/util/costum_card2.dart';
import 'package:book_app/function/book_db_function.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/material.dart';

class AdminViewScreen extends StatefulWidget {
  const AdminViewScreen({super.key});

  @override
  State<AdminViewScreen> createState() => _AdminViewScreenState();
}

class _AdminViewScreenState extends State<AdminViewScreen> {
  TextEditingController _searchController = TextEditingController();
  bool isSearching = false;
  List<Book> filteredBook = [];

  Future<void> filterBooks(String query) async {
    setState(() {
      filteredBook = bookListnotifier.value.where(
        (book) {
          return book.bookName.toLowerCase().contains(query.toLowerCase()) ||
              book.authors.name.toLowerCase().contains(query.toLowerCase()) ||
              book.genre.name.toLowerCase().contains(query.toLowerCase());
        },
      ).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getAllBooks();
    _searchController.addListener(() {
      filterBooks(_searchController.text);
      setState(() {
        isSearching = _searchController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getAllBooks();
    return Scaffold(
        backgroundColor: CostumColor().costum_color_6,
        appBar: AppBar(
          backgroundColor: CostumColor().costum_color_6,
          centerTitle: true,
          title: Text(
              style: CostumFontStyle(
                      color: CostumColor().costum_color_1,
                      fontSize: 20,
                      fontWeight: FontWeight.w400)
                  .getFontstyle(),
              'Admin'),
          // actions: [
          //   MenuBar(children: )
          // ],
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _searchController,
              onTap: () {
                setState(() {
                  isSearching = true;
                });
              },
              style: CostumFontStyle(
                      color: CostumColor().costum_color_3,
                      fontSize: 13,
                      fontWeight: FontWeight.normal)
                  .getFontstyle_2(),
              decoration: InputDecoration(
                  hintText: 'Search books',
                  hintStyle: CostumFontStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.normal)
                      .getFontstyle_2(),
                  filled: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0)),
                  suffixIcon: isSearching
                      ? IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              isSearching = false;
                              filteredBook.clear();
                            });
                          },
                        )
                      : const Icon(Icons.search)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: isSearching
                ? filteredBook.isEmpty
                    ? Center(
                        child: Text(
                            style: CostumFontStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal)
                                .getFontstyle(),
                            'No books found'),
                      )
                    : GestureDetector(
                        onTap: () {},
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            final book = filteredBook[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: SizedBox(
                                height: ResponsiveHelper(context)
                                    .getResponsiveHeight(
                                        20), // Increase the height as needed
                                child: Row(
                                  children: [
                                    // Leading Image
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              CostumBookviewScreen(
                                                  name: book.bookName),
                                        ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            File(book.image_path),
                                            width: ResponsiveHelper(context)
                                                .getResponsiveWidth(
                                                    30), // Adjust width for larger leading
                                            height: ResponsiveHelper(context)
                                                .getResponsiveHeight(
                                                    50), // Increase height as desired
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Title and Subtitle Text
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              book.bookName,
                                              style: CostumFontStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    20, // Adjust font size as needed
                                                fontWeight: FontWeight.bold,
                                              ).getFontstyle(),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              book.authors.name,
                                              style: CostumFontStyle(
                                                      color: Colors.white70,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal)
                                                  .getFontstyle(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 0,
                            height: 0,
                          ),
                          itemCount: filteredBook.length,
                        ),
                      )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const CostumHomescreenDetails(
                            title: 'New Releases', isAdmin: true),
                        const SizedBox(
                          height: 20,
                        ),
                        const CostumHomescreenDetails(
                          title: 'Want to Read',
                          isAdmin: true,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          height:
                              ResponsiveHelper(context).getResponsiveHeight(70),
                          width: double.infinity,
                          decoration: BoxDecoration(
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
                                    child: Text(
                                        style: CostumFontStyle(
                                                color: CostumColor()
                                                    .costum_color_1,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)
                                            .getFontstyle(),
                                        'More to Explore'),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: ResponsiveHelper(context)
                                    .getResponsiveHeight(60),
                                width: ResponsiveHelper(context)
                                    .getResponsiveWidth(85),
                                child: Costumcard2(isAdmin: true),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const CostumHomescreenDetails(
                          title: 'Recently Read',
                          isAdmin: true,
                        ),
                        // ValueListenableBuilder(
                        //   valueListenable: bookListnotifier,
                        //   builder: (context, books, child) {
                        //     return Column(
                        //       children: books.map((book) {
                        //         double progress = (book.readingTimeInsecond /
                        //                 book.targetTimeInsecond) *
                        //             100;
                        //         return ListTile(
                        //           title: Text(book.bookName),
                        //           subtitle: Text(
                        //               'Reading Progress: ${progress.toStringAsFixed(2)}%'),
                        //           trailing: Text(
                        //               'Time Read: ${book.readingTimeInsecond ~/ 60}:${book.readingTimeInsecond % 60}'),
                        //         );
                        //       }).toList(),
                        //     );
                        //   },
                        // )
                      ],
                    ),
                  ),
          )
        ]));
  }
}
