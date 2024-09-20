import 'package:book_app/User/book_card.dart';
import 'package:book_app/User/costum_bookview_screen.dart';
import 'package:book_app/User/costum_card.dart';
import 'package:book_app/User/catogories_screen.dart';
import 'package:book_app/User/navigator_screen.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
      
      ),
      home:NavigatorScreen()
    );
  }
}