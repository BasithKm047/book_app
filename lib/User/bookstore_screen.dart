
import 'package:book_app/User/costum_grid.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BookstoreScreen extends StatelessWidget {
   const BookstoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(style: CostumFontStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400).getFontstyle(), 'Book Store'),
        ),
      ),
      body: CostumGrid(isAdmin: false,)
    );
  }
 
}
