import 'package:book_app/model/book_model.dart';
import 'package:book_app/util/book_card.dart';
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          style: CostumFontStyle(fontSize: 20, fontWeight: FontWeight.w400,color:Colors.white).getFontstyle(),

          title),

        

      ),
      body: ValueListenableBuilder(
        valueListenable: bookListnotifier,
        builder: (context, bookList, child) {
          List<Book>filteredBooks=[];
          if(title=='Favourite'){
            filteredBooks=bookList.where((book)=>book.isFavourite).toList();
          }else if(title=='Want to Read'){
            filteredBooks=bookList.where((book)=>book.isWantToRead).toList();
          }else if(title=='Finished'){
            filteredBooks=bookList.where((book)=>book.isFinished).toList();
          }
          
          return  GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.50,
        ), itemBuilder: (context, index) {
          return BookCard(title: filteredBooks[index].bookName,isAdmin: false,imagePath: filteredBooks[index].image_path,isLanguage: false,);
          

        },
        itemCount: filteredBooks.length,);
        },
        
      ),
    );
  }
}