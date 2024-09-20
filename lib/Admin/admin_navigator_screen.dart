import 'package:book_app/Admin/admin_details_screen.dart';
import 'package:book_app/Admin/admin_view_screen.dart';
import 'package:book_app/Admin/details_adding_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class AdminNavigatorScreen extends StatefulWidget {
  const AdminNavigatorScreen({super.key});

  @override
  State<AdminNavigatorScreen> createState() => _AdminviewScreenState();
}

class _AdminviewScreenState extends State<AdminNavigatorScreen> {
int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     
      body: _pages[selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
      onTap: onTappedItems,
        backgroundColor: CostumColor().costum_color,
        items: const [
        Icon(Icons.view_cozy),
        Icon(Icons.add_box_outlined),
        Icon(Boxicons.bx_user)


      ]),
    );
  }
  final List <Widget>_pages=[
       const AdminViewScreen(),
       const   DetailsAddingScreen(),
    const AdminDetailsScreen(),

  ];

  onTappedItems(index){
    setState(() {
      selectedIndex=index;
    });
  }
}