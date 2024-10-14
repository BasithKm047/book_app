
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
  List<Book> filteredBook = [];

  Future<void> filterBooks() async {
    String searchTExt = _searchController.text.toLowerCase();
    setState(() {
      filteredBook = bookListbyGenreNotifier.value.where(
        (book) {
          return book.bookName.toLowerCase().contains(searchTExt);
        },
      ).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getAllBooks();
    _searchController.addListener(() {
      filterBooks();
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
      body: Scrollbar(
        radius: const Radius.circular(10),
        thickness: 4,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextFormField(
              //     controller: _searchController,
              //     decoration: InputDecoration(
              //       fillColor: CostumColor().costum_color,
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10),
              //           borderSide:  BorderSide(color: CostumColor().costum_color)),
              //       labelText: 'Search',
              //       suffixIcon: const Icon(Icons.search),
              //     ),
              //   ),
              // ),
              // filteredBook.isNotEmpty
              //     ? SizedBox(
              //         height: 200,
              //         child: ListView.separated(
              //           separatorBuilder: (context, index) => const Divider(),
              //           itemCount: filteredBook.length,
              //           itemBuilder: (context, index) {
              //             final book = filteredBook[index];
              //             return ListTile(
              //               leading: Image.file(
              //                   fit: BoxFit.cover, File(book.image_path)),
              //               title: Text(book.bookName),
              //             );
              //           },
              //         ),
              //       )
              //     : const SizedBox.shrink(),
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
                height: 30,
              ),
              const CostumHomescreenDetails(
                title: 'Finished',
                isAdmin: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
