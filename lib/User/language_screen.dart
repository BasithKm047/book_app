import 'package:book_app/util/costum_grid_for_language.dart';
import 'package:flutter/material.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        body: Center(child: CostumGridForLanguage(isAdmin: false, isLanguage: true),),
      ),
    );
  }
}