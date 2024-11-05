import 'dart:io';

import 'package:book_app/function/book_db_function.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/material.dart';

class CostumSearchScreen extends StatefulWidget {
  const CostumSearchScreen({super.key});

  @override
  State<CostumSearchScreen> createState() => _CostumSearchScreenState();
}

class _CostumSearchScreenState extends State<CostumSearchScreen> {
  TextEditingController search_controller = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    search_controller.addListener(() {
      setState(() {
        searchQuery = search_controller.text;
      });
    });
  }

  @override
  void dispose() {
    search_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
            child: TextFormField(
              controller: search_controller,
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
                  suffixIcon: const Icon(Icons.search)),
            ),
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: bookListnotifier,
          builder: (context, bookList, child) {
            final bookdetails = bookList.where((book) {
              final lowerQuery = searchQuery.toLowerCase();
              return book.bookName.toLowerCase().contains(lowerQuery) ||
                  book.language.language.toLowerCase().contains(lowerQuery) ||
                  book.genre.name.toLowerCase().contains(lowerQuery) ||
                  book.authors.name.toLowerCase().contains(lowerQuery);
            }).toList();
            if (searchQuery.isNotEmpty && bookdetails.isEmpty) {
              return Center(
                child: Text(
                    style: CostumFontStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal)
                        .getFontstyle(),
                    'Book not found'),
              );
            }
            return ListView.separated(
              itemCount: bookdetails.length,
              itemBuilder: (context, index) {
                final book = bookdetails[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    height: ResponsiveHelper(context).getResponsiveHeight(
                        25), // Increase the height as needed
                    child: Row(
                      children: [
                        // Leading Image
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(book.image_path),
                              width: ResponsiveHelper(context)
                                  .getResponsiveWidth(
                                      30), // Adjust width for larger leading
                              height: ResponsiveHelper(context)
                                  .getResponsiveHeight(
                                      60), // Increase height as desired
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Title and Subtitle Text
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  book.bookName,
                                  style: CostumFontStyle(
                                    color: Colors.white,
                                    fontSize: 20, // Adjust font size as needed
                                    fontWeight: FontWeight.bold,
                                  ).getFontstyle(),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  book.authors.name,
                                  style: CostumFontStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal)
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
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.grey),
            );
          },
        ),
      ),
    );
  }
}
