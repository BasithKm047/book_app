import 'package:book_app/util/costum_rounded_grid.dart';
import 'package:flutter/material.dart';

class AdminAuthorScreen extends StatelessWidget {
  final bool isAdmin;
  const AdminAuthorScreen({super.key, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
     body: SafeArea(child:
     CostumRoundedGrid(isAdmin: isAdmin)
     ),
    );
  }
}