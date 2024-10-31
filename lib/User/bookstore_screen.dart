
import 'package:book_app/util/costum_grid.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BookstoreScreen extends StatelessWidget {
   const BookstoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
      
        backgroundColor: Colors.black,
       
        body: CostumGrid(isAdmin: false,isGenre: true,)
      ),
    );
  }
 
}
