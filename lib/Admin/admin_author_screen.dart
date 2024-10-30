import 'package:book_app/util/costum_rounded_grid.dart';
import 'package:flutter/material.dart';

class AdminAuthorScreen extends StatelessWidget {
  const AdminAuthorScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return   const Scaffold(
     body: SafeArea(child:
     CostumRoundedGrid(isAdmin: true,isAUthor: true,)
     ),
    );
  }
}