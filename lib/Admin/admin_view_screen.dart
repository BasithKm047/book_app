import 'package:book_app/User/book_card.dart';
import 'package:book_app/User/costum_homescreen_details.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class AdminViewScreen extends StatelessWidget {
  const AdminViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          style: CostumFontStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400).getFontstyle(),
          'Admin'),
      ),
      body: const Column(children: [

        CostumHomescreenDetails(title: 'Want to Read', imagePath:'Asset/Fiction_books_1_image_1.jpg' )

      ],),
    );
  }
}