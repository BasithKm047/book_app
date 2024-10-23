import 'package:book_app/Admin/admin_details_screen.dart';
import 'package:book_app/Admin/admin_tabcontroller_screen.dart';
import 'package:book_app/Admin/admin_view_screen.dart';
import 'package:book_app/Admin/details_adding_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class AdminNavigatorScreen extends StatefulWidget {
  final String ?name;
  final String ?image_path;
   AdminNavigatorScreen({super.key, this.name, this.image_path});

  @override
  State<AdminNavigatorScreen> createState() => _AdminviewScreenState();
}

class _AdminviewScreenState extends State<AdminNavigatorScreen> {
int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
      final List <Widget>_pages=[
       const AdminViewScreen(),
       const AdminTabcontrollerScreen(),
         DetailsAddingScreen(),
     AdminDetailsScreen(image_path: widget.image_path,name: widget.name,),

  ];

    return Scaffold(
      backgroundColor:  CostumColor().costum_color_3,
     
      body: _pages[selectedIndex],
      bottomNavigationBar:  SizedBox(
  height: 83,
  child: DotNavigationBar(
    marginR: const EdgeInsets.only(bottom: 0),
  
    
  
    backgroundColor: Colors.transparent,
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

  onTappedItems(index){
    setState(() {
      selectedIndex=index;
    });
  }

   List navigationItems=[
    const Icon(Icons.view_cozy),
     const Icon(Icons.grid_view_outlined),
        const Icon(Icons.add_box_outlined),
        const Icon(Boxicons.bx_user)
   ];
}