
import 'package:book_app/User/custom_listview.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 30,
                    ),
                    'Generes'),
              ],
            ),
          ),
          const Divider(
            thickness: .5,
            color: Colors.grey,
          ),
          Expanded(
            child: CustomListview(scrollDirection: Axis.vertical,),
          
          )
        ],
      ),
    );
  }
 
}
