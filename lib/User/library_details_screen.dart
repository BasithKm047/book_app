import 'package:book_app/User/book_card.dart';
import 'package:book_app/function/book_db_function.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';

class LibraryDetailsScreen extends StatelessWidget {
  final String title;
  
  const LibraryDetailsScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    getAllBooks();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          style: CostumFontStyle(fontSize: 20, fontWeight: FontWeight.w400,color:Colors.black).getFontstyle(),

          title),

        

      ),
      body: ValueListenableBuilder(
        valueListenable: bookListnotifier,
        builder: (context, value, child) {
          return  GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.50,
        ), itemBuilder: (context, index) {
          return BookCard(title: value[index].bookName,isAdmin: false,imagePath: value[index].image_path,);
        },
        itemCount: value.length,);
        },
        
      ),
    );
  }
}