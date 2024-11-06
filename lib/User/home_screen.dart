import 'dart:io';

import 'package:book_app/User/user_details_screen.dart';
import 'package:book_app/util/common_function.dart';
import 'package:book_app/util/costum_bookview_screen.dart';
import 'package:book_app/util/costum_homescreen_details.dart';
import 'package:book_app/util/costum_card2.dart';
import 'package:book_app/function/book_db_function.dart';
import 'package:book_app/function/genres_db_function.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  String? userName;
  String? image_path;
  HomeScreen({super.key, this.userName, this.image_path});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Book> filtredBooks = [];
  bool isSearching = false;
  @override
  void initState() {
    super.initState();
    getAllBooks().then((_) {
      setState(() {
        filtredBooks = bookListnotifier.value;
      });
    });
    _searchController.addListener(() {
      filterBook(_searchController.text);
      setState(() {
        isSearching = _searchController.text.isNotEmpty;
      });
    });
    getAllGenres();
  }

  Future<void> filterBook(String query) async {
    setState(() {
      filtredBooks = bookListnotifier.value.where(
        (book) {
          return book.bookName.toLowerCase().contains(query.toLowerCase()) ||
              book.authors.name.toLowerCase().contains(query.toLowerCase()) ||
              book.genre.name.toLowerCase().contains(query.toLowerCase());
        },
      ).toList();
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    getAllBooks();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserDetailsScreen(
                    image_path: widget.image_path,
                    name: widget.userName,
                  ),
                ));
              },
              child: CircleAvatar(
                backgroundImage: widget.image_path != null
                    ? FileImage(File(widget.image_path!))
                    : const AssetImage('Asset/download_1.jpeg'),
              ),
            ),
          ),
        ],
        title: Text(
          "Home",
          style: CostumFontStyle(
                  color: CostumColor().costum_color_1,
                  fontSize: 20,
                  fontWeight: FontWeight.w400)
              .getFontstyle(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
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
                            _searchController.clear();
                            filtredBooks = bookListnotifier.value;
                          });
                        },
                      )
                    : const Icon(Icons.search),
              ),
            ),
          ),
          isSearching && filtredBooks.isEmpty
              ? Center(
                  child: Text(
                    'No books found',
                    style: CostumFontStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal)
                        .getFontstyle(),
                  ),
                )
              : isSearching
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            final book = filtredBooks[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CostumBookviewScreen(
                                    name: book.bookName,
                                  ),
                                ));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: SizedBox(
                                  height: ResponsiveHelper(context)
                                      .getResponsiveHeight(20),
                                  child: Row(
                                    children: [
                                      // Leading Image
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            File(book.image_path),
                                            width: ResponsiveHelper(context)
                                                .getResponsiveWidth(30),
                                            height: ResponsiveHelper(context)
                                                .getResponsiveHeight(50),
                                            fit: BoxFit.cover,
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
                                                  fontSize: 20,
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
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 0,
                            height: 0,
                          ),
                          itemCount: filtredBooks.length,
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Hi ${widget.userName}',
                                  style: CostumFontStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400)
                                      .getFontstyle(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'What do you want to read today?',
                                  style: CostumFontStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400)
                                      .getFontstyle(),
                                ),
                              ),
                              const SizedBox(height: 30),
                              CostumHomescreenDetails(
                                  title: newReleases, isAdmin: false),
                              const SizedBox(height: 30),
                              const CostumHomescreenDetails(
                                title: 'Want to Read',
                                isAdmin: false,
                              ),
                              const SizedBox(height: 30),
                              Container(
                                height: ResponsiveHelper(context)
                                    .getResponsiveHeight(70),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: CostumColor().costum_color_4,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'More to Explore',
                                            style: CostumFontStyle(
                                                    color: CostumColor()
                                                        .costum_color_1,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold)
                                                .getFontstyle(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      height: ResponsiveHelper(context)
                                          .getResponsiveHeight(60),
                                      width: ResponsiveHelper(context)
                                          .getResponsiveWidth(85),
                                      child: Costumcard2(isAdmin: false),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              const CostumHomescreenDetails(
                                title: 'Recently Read',
                                isAdmin: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
        ],
      ),
    );
  }
}
