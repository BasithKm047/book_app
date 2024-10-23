import 'package:book_app/User/book_card.dart';
import 'package:book_app/function/book_db_function.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class CatogoriesScreen extends StatefulWidget {
  final String title;
  final bool isAdmin;
  final bool isLanguage;
  const CatogoriesScreen({super.key, required this.title, required this.isAdmin, required this.isLanguage});

  @override
  State<CatogoriesScreen> createState() => _CatogoriesScreenState();
}


class _CatogoriesScreenState extends State<CatogoriesScreen> {
  @override
  void initState() {
    super.initState();
    getBooksByGenre(widget.title);
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CostumColor().costum_color_6,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CostumColor().costum_color_6,
        title:  Text(
          style: CostumFontStyle(fontSize: 20, fontWeight: FontWeight.w400,color:Colors.white).getFontstyle(),
          widget.title),
      ),
      body:
         widget.isLanguage!=true?
        ValueListenableBuilder(
        valueListenable: bookListbyGenreNotifier,
        builder: (context, List<Book>bookDetails, child) {
          return  GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.50,
        ), itemBuilder: (context, index) {
          final book=bookDetails[index];
          return BookCard(
            imagePath: book.image_path,
            title: book.bookName,
            isAdmin: widget.isAdmin,
            icon: const Icon(Icons.delete),
            icon_2:  const Icon(
              Boxicons.bx_edit),
               isLanguage: false,
            // onDelete: (book) => deleteBook(book), 
            // onUpdate: () => updateBooks,

          
          );
        
        },
        itemCount: bookDetails.length,
        );
        },
        
      ): ValueListenableBuilder(
         
        valueListenable: bookListbyGenreNotifier,
        builder: (context, List<Book>bookDetails, child) {
          return  GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.50,
        ), itemBuilder: (context, index) {
          final book=bookDetails[index];
          return BookCard(
            imagePath: book.image_path,
            title: book.bookName,
            isAdmin: widget.isAdmin,
            icon: const Icon(Icons.delete),
            icon_2:  const Icon(
              Boxicons.bx_edit),
              isLanguage: true,
            // onDelete: (book) => deleteBook(book), 
            // onUpdate: () => updateBooks,

          
          );
        
        },
        itemCount: bookDetails.length,
        );
        },
        
      )
    );
  }
  // void deleteBook(Book bookDetails){
  //   deleteBooks(bookDetails);
    
  // }

  // void updateBooks(Book bookDetails){
  //   updateBook(bookDetails);

  // }
}