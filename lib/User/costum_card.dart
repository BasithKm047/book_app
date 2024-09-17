import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CostumCard extends StatelessWidget {
  final String title;
  final String imagePath;
  const CostumCard({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 200,
        width: 300,
        child: Card(
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 104, 175, 107),
                border: Border.all(
                  color: Colors.grey,
                  width: .5,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.grey,
                    offset: Offset(0, 1),
                    // spreadRadius: 2
                  )
                ]),

            width: 300,

            // color: Colors.amber,
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                          style: GoogleFonts.lora(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          'Fiction'),
                    )),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                                fit: BoxFit.cover, 'Asset/book_image_2.jpg'),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
