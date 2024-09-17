
import 'package:book_app/User/costum_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookstoreScreen extends StatelessWidget {
  const BookstoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(style: GoogleFonts.lora(), 'Book Store'),
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
            child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){},
                  child: const CostumCard(title: 'Fiction', imagePath:  'Asset/book_image_2.jpg'));
              },
              itemCount: 5,
              separatorBuilder: (context, index) => const Divider(
                thickness: 1,
                color: Colors.blueGrey,
              ),
            ),
          
          )
        ],
      ),
    );
  }
}
