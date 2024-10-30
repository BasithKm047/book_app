import 'package:book_app/Admin/language_adding_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/costum_grid_for_language.dart';
import 'package:flutter/material.dart';

class AdminLangugeScreen extends StatelessWidget {
  const AdminLangugeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: CostumGridForLanguage(isAdmin: true,isLanguage: true,)),
       floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: CostumColor().costum_color_4),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const LanguageAddingScreen(),
              ));
            },
            child: Icon(color: CostumColor().costum_color_1, Icons.add),
          ),
        )
       ),
      
    );
  }
}