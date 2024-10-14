import 'package:book_app/util/costum_grid_for_language.dart';
import 'package:flutter/material.dart';

class AdminLangugeScreen extends StatelessWidget {
  const AdminLangugeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: CostumGridForLanguage(isAdmin: true)),
    );
  }
}