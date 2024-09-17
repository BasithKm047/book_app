import 'package:book_app/User/bookstore_screen.dart';
import 'package:book_app/User/home_screen.dart';
import 'package:book_app/User/library_screen.dart';
import 'package:book_app/User/search_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int selectedIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const BookstoreScreen(),
     LibraryScreen(),
    const SearchScreen(),
  ];

  List<Widget> navigationItems = [
    Icon(Icons.home),
    Icon(Icons.shopping_bag),
    Icon(Boxicons.bx_library),
    Icon(Boxicons.bx_search)

    // BottomNavigationBarItem(label: 'Home', icon: Icon(
    //     // color: Colors.black,
    //     Icons.home)),
    // BottomNavigationBarItem(
    //     label: 'Book Store', icon: Icon(

    //       Icons.shopping_bag)),
    // BottomNavigationBarItem(
    //     label: 'Library', icon: Icon(Boxicons.bx_library)),

    //    icon: Icon(Boxicons.bx_search),
  ];

  void onTapedItems(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
          ),
          child: CurvedNavigationBar(
            // buttonBackgroundColor: Color.fromARGB(255, 104, 175, 107),
            color: Colors.white,
            backgroundColor:CostumColor().costum_color,
            // height: 15,
          
            // backgroundColor: const Color.fromARGB(255, 104, 175, 107),
          
            onTap: onTapedItems,
            items: navigationItems,
          ),
        ));
  }
}
