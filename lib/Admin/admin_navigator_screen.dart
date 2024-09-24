import 'package:book_app/Admin/admin_details_screen.dart';
import 'package:book_app/Admin/admin_view_screen.dart';
import 'package:book_app/Admin/details_adding_screen.dart';
import 'package:book_app/Admin/admin_catogaries.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
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
      bottomNavigationBar:  SizedBox(
  height: 83,
  child: DotNavigationBar(
    marginR: const EdgeInsets.only(bottom: 0),
  
    
  
    backgroundColor: CostumColor().costum_color_3,
    selectedItemColor: Colors.white,
    splashColor: Colors.transparent,
    enableFloatingNavBar: true,
    duration: const Duration(seconds: 0),
    items: [
    DotNavigationBarItem(icon: navigationItems[0]),
    DotNavigationBarItem(icon: navigationItems[1]),
    DotNavigationBarItem(icon: navigationItems[2]),
    DotNavigationBarItem(icon: navigationItems[3]),
  ],
  onTap:(index) => onTappedItems(index),
  currentIndex: selectedIndex,
  dotIndicatorColor: CostumColor().costum_color,
  unselectedItemColor: CostumColor().costum_color_2,
  splashBorderRadius: 30,
   margin: const EdgeInsets.all(20),
  ),
),

      
      
      // CurvedNavigationBar(
      // onTap: onTappedItems,
      //   backgroundColor: CostumColor().costum_color,
      //   items: const [
        


      // ]),
    );
  }
  final List <Widget>_pages=[
       const AdminViewScreen(),
       const AdminCatogaries(),
       const   DetailsAddingScreen(),
    const AdminDetailsScreen(),

  ];

  onTappedItems(index){
    setState(() {
      selectedIndex=index;
    });
  }

   List navigationItems=[
    Icon(Icons.view_cozy),
     Icon(Icons.grid_view_outlined),
        Icon(Icons.add_box_outlined),
        Icon(Boxicons.bx_user)
   ];
}