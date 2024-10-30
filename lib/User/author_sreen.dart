import 'package:book_app/util/costum_rounded_grid.dart';
import 'package:flutter/material.dart';

class AuthorSreen extends StatelessWidget {
  const AuthorSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Scaffold(
        body: CostumRoundedGrid(isAdmin: false, isAUthor: true),
      ),
    );
  }
}