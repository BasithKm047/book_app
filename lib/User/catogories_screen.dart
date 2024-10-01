import 'package:book_app/User/book_card.dart';
import 'package:book_app/function/book_db_function.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class CatogoriesScreen extends StatefulWidget {
  final String title;
  final bool isAdmin;
  const CatogoriesScreen({super.key, required this.title, required this.isAdmin});

  @override
  State<CatogoriesScreen> createState() => _CatogoriesScreenState();
}


class _CatogoriesScreenState extends State<CatogoriesScreen> {
  @override
  void initState() {
    super.initState();
    getAllBooks();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title:  Text(
          style: CostumFontStyle(fontSize: 20, fontWeight: FontWeight.w400,color:Colors.black).getFontstyle(),
          widget.title),
      ),
      body: ValueListenableBuilder(
        valueListenable: bookListnotifier,
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
            icon_2: const Icon(Boxicons.bx_edit),
            // onDelete: (book) => deleteBook(book), 
            // onUpdate: () => updateBooks,

          
          );
        
        },
        itemCount: bookDetails.length,
        );
        },
        
      ),
    );
  }
  // void deleteBook(Book bookDetails){
  //   deleteBooks(bookDetails);
    
  // }

  // void updateBooks(Book bookDetails){
  //   updateBook(bookDetails);

  // }
}