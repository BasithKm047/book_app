import 'dart:io';

import 'package:book_app/Admin/admin_login_screen.dart';
import 'package:book_app/User/costum_homescreen_details.dart';
import 'package:book_app/User/custom_listview.dart';
import 'package:book_app/function/book_db_function.dart';
import 'package:book_app/function/genres_db_function.dart';
import 'package:book_app/function/user_db_function.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/model/genres_model.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Book> filtredBooks = [];
  @override
  void initState() {
    super.initState();
    getAllBooks();
    _searchController.addListener(() {
      filterBook();
    });
    getAllGenres();
  }

  Future<void> filterBook() async {
    String searchTExt = _searchController.text.toLowerCase();
    setState(() {
      if (searchTExt.isNotEmpty) {
        filtredBooks = bookListnotifier.value
            .where((book) => book.bookName.toLowerCase().contains(searchTExt))
            .toList();
      } else {
        filtredBooks = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.amber,
            ),
          ),
          title: Text(style: GoogleFonts.lora(), "Home"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AdminLoginScreen(),
                  ));
                },
                icon: const Icon(
                    size: 30.0, color: Colors.grey, Icons.admin_panel_settings))
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: bookListnotifier,
          builder: (context, value, child) {
            return Scrollbar(
              thickness: 4,
              radius: const Radius.circular(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey)),
                          labelText: 'Search',
                          suffixIcon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                    // const SizedBox(height:10,),

                    filtredBooks.isNotEmpty
                        ? SizedBox(
                            height: 200,
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: filtredBooks.length,
                              itemBuilder: (context, index) {
                                final book = filtredBooks;
                                return ListTile(
                                  leading: Image.file(
                                      fit: BoxFit.cover,
                                      File(book[index].image_path)),
                                  title: Text(book[index].bookName),
                                );
                              },
                            ),
                          )
                        : const SizedBox.shrink(),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ValueListenableBuilder(
                        valueListenable: userList_notifier,
                        builder: (context, value, child) {
                          //  final userList=value.firstWhere((element) => element==userList_notifier.value,);
                          return Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      style: GoogleFonts.lora(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      'user'),
                                  Text(
                                      style: GoogleFonts.lora(
                                        fontWeight: FontWeight.w400,
                                        color: CostumColor().costum_color,
                                      ),
                                      'What you want to read today?')
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const CostumHomescreenDetails(
                      title: 'Want to Read',
                      isAdmin: false,
                      //  genres: GenresModel(value[0].id, name: value[0].name),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, -3),
                            blurRadius: 25,
                            // spreadRadius: 3,
                          )
                        ],
                        color: Colors.white,
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
                                    style: GoogleFonts.lora(
                                        // color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    'More to Explore'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 200,
                            child: InkWell(
                                child: CustomListview(
                              scrollDirection: Axis.horizontal,
                              isAdmin: false,
                            )),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    const CostumHomescreenDetails(
                      title: 'Finished',
                      isAdmin: false,
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
