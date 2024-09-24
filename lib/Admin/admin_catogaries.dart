import 'package:book_app/User/costum_grid.dart';
import 'package:flutter/material.dart';

class AdminCatogaries extends StatelessWidget {
  const AdminCatogaries({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
        child: SafeArea(child: CostumGrid(isAdmin: true)),
      ),
    );
  }
}