import 'dart:io';

import 'package:book_app/User/book_reader_screen.dart';
import 'package:book_app/function/book_db_function.dart';
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
  var isAdd = false;

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
      body: ValueListenableBuilder(
        valueListenable: bookListnotifier,
        builder: (context, bookList, child) {
          final bookDetails = bookList.firstWhere(
            (book) => book.bookName == widget.name,
          );

          return Column(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttons('Favourite',addtoFav),
                  const SizedBox(
                    width: 10,
                  ),
                  buttons('Want to Read',addtoWantToRead),
                 
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
                    borderRadius: BorderRadius.circular(20)),
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
                        'Read')),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buttons(String text,Function onTap) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            minimumSize: Size(ResponsiveHelper(context).getResponsiveWidth(5),
                ResponsiveHelper(context).getResponsiveHeight(6)),
            backgroundColor: CostumColor().costum_color_4),
        onPressed: () {
      onTap;
        },
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),

            Icon(
                color: CostumColor().costum_color_1,
                Icons.add_circle_outline_outlined),
            Text(
                style: CostumFontStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.normal)
                    .getFontstyle(),
                text)
          ],
        ));
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
  Future<void>addtoFav()async{
    
   





  }

  Future<void>addtoWantToRead()async{

  }
}
