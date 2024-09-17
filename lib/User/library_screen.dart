import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class LibraryScreen extends StatelessWidget {
   LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 16.0,left: 8.0),
            child: Text(
              style: GoogleFonts.lora(
        
              ),
              'Library'),
          ),
        ),
      ),
      body: ListView.separated(itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            style: GoogleFonts.lora(
              fontWeight: FontWeight.w400,
            ),
            LibrarDetails[index]),
          trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios)),
        );
      }, separatorBuilder: (context, index) => Divider(), itemCount: 3),
    );
  }
  
    List LibrarDetails=[
      'Favourite',
      'Want to Read',
      'Finished'


    ];
  
}