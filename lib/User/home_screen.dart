import 'dart:io';

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
   String ?userName;
   String ?image_path;
   HomeScreen({super.key,  this.userName,this.image_path});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Book> filtredBooks = [];
  @override
  void initState() {
    super.initState();
    getAllBooks().then((_){
      setState(() {
        filtredBooks=bookListnotifier.value;
        
      });
    });
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
    return 
       Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            actions: [
               Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                // backgroundColor: Colors.amber,
                backgroundImage: FileImage(File(widget.image_path??'')),
              ),
            ),
            ],

            
            title: Text(style:CostumFontStyle(color: CostumColor().costum_color_1, fontSize: 20, fontWeight: FontWeight.w400).getFontstyle(), "Home",),
          ),
          body: ValueListenableBuilder(
            valueListenable: bookListnotifier,
            builder: (context, value, child) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextFormField(
                    //     controller: _searchController,
                    //     decoration: InputDecoration(
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(10),
                    //           borderSide: const BorderSide(color: Colors.grey)),
                    //       labelText: 'Search',
                    //       suffixIcon: const Icon(Icons.search),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height:10,),
                    
                    // filtredBooks.isNotEmpty
                    //     ? SizedBox(
                    //         height: 200,
                    //         child: ListView.separated(
                    //           separatorBuilder: (context, index) =>
                    //               const Divider(),
                    //           itemCount: filtredBooks.length,
                    //           itemBuilder: (context, index) {
                    //             final book = filtredBooks[index];
                    //             return ListTile(
                    //               onTap: (){
                    //                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => CostumBookviewScreen(name: book.bookName),));
                    //               },
                    //               leading: Image.file(
                    //                   fit: BoxFit.cover,
                    //                   File(book.image_path)),
                    //               title: Text(book.bookName),
                    //             );
                    //           },
                    //         ),
                    //       )
                    //     : const SizedBox.shrink(),
                    
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                               style: CostumFontStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400).getFontstyle(),
                                  'Hi ${widget.userName}'),
                              Text(
                                  style:  CostumFontStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400).getFontstyle(),
                                  'What you want to read today?')
                            ],
                          ),
                        ],
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
                height: ResponsiveHelper(context).getResponsiveHeight(70),
                width: double.infinity,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.all(Radius.circular(10)),
                  // boxShadow: const [
                  //   // BoxShadow(
                  //   //   color: Colors.grey,
                  //   //   offset: Offset(0, -3),
                  //   //   blurRadius: 25,
                  //   //   // spreadRadius: 3,
                  //   // )
                  // ],
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
                                      color: CostumColor().costum_color_1,
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
                      height: ResponsiveHelper(context).getResponsiveHeight(60),
                      width: ResponsiveHelper(context).getResponsiveWidth(85),
                      
                      child: Costumcard2( isAdmin: true),
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
              );
            },
          )
    );
  }
}
