import 'package:book_app/User/book_card.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class CatogoriesScreen extends StatelessWidget {
  final String title;
  final bool isAdmin;
  const CatogoriesScreen({super.key, required this.title, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title:  Text(
          style: CostumFontStyle(fontSize: 20, fontWeight: FontWeight.w400,color:Colors.black).getFontstyle(),
          title),
      ),
      body: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 0.50,
      ), itemBuilder: (context, index) {
        return BookCard(
          imagePath: 'Asset/Fiction_books_1_image_1.jpg',
          title: 'name',
          isAdmin: isAdmin,
          icon: const Icon(Icons.delete),
          icon_2: const Icon(Boxicons.bx_edit),
        
        );

      },
      itemCount: 6,
      ),
    );
  }
}