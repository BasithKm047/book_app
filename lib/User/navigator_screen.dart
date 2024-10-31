import 'package:book_app/User/home_screen.dart';
import 'package:book_app/User/library_screen.dart';
import 'package:book_app/User/tab_cotroller.dart';
import 'package:book_app/User/user_details_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class NavigatorScreen extends StatefulWidget {
    String ?userName;
   String ?image_path;
   NavigatorScreen({super.key, this.image_path, this.userName});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  late List<Widget> _pages;
  int selectedIndex = 0;
  
  @override
  void initState() {
    super.initState();
   _pages = [
     HomeScreen(image_path: widget.image_path,userName: widget.userName,),
     const TabcontrollerScreen(),
    LibraryScreen(),
   UserDetailsScreen(image_path: widget.image_path, name: widget.userName,),
  ];

  }
  // List<Widget> navigationItems = [
  //   BottomNavigationBarItem(label: 'Home', icon: Icon(
  //       // color: Colors.black,
  //       Icons.home)),
  //   BottomNavigationBarItem(
  //       label: 'Book Store', icon: Icon(

  //         Icons.shopping_bag)),
  //   BottomNavigationBarItem(
  //       label: 'Library', icon: Icon(Boxicons.bx_library)),

  //      icon: Icon(Boxicons.bx_search),
  // ];

  void onTapedItems(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CostumColor().costum_color_3,
      body: _pages[selectedIndex],
bottomNavigationBar: SizedBox(
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
  onTap:(index) => onTapedItems(index),
  currentIndex: selectedIndex,
  dotIndicatorColor: CostumColor().costum_color,
  unselectedItemColor: CostumColor().costum_color_2,
  splashBorderRadius: 30,
   margin: const EdgeInsets.all(20),
  ),
),

// bottomNavigationBar: StylishBottomBar(items: [
//   BottomBarItem(icon: navigationItems[0], title:  const Text('Home')),
//   BottomBarItem(icon: navigationItems[1], title:  const Text('Book Shop')),
//   BottomBarItem(icon: navigationItems[2], title:  const Text('Library'))

  
  

// ], option: DotBarOptions(
//   dotStyle: DotStyle.tile,
//   gradient: LinearGradient(colors: [
//     CostumColor().costum_color,
//     Colors.white,
    
//   ],
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight),

// ),
// hasNotch: true,
// fabLocation: StylishBarFabLocation.end,
// currentIndex: selectedIndex,
// notchStyle: NotchStyle.square,
// onTap: onTapedItems,
// iconSpace: BorderSide.strokeAlignCenter,
// borderRadius: BorderRadius.circular(15),
// elevation: 5,
// ),

      // bottomNavigationBar: FlashyTabBar(items: [
      //   FlashyTabBarItem(icon: const Icon(Icons.home), title: const Text('Home'),
      //   ),
      //   FlashyTabBarItem(icon: const Icon(Icons.shopping_bag), title: const Text('Book Store'),
      //   ),
      //  FlashyTabBarItem(icon: const Icon(Boxicons.bx_library), title: const Text('Library'))
      // ], onItemSelected:onTapedItems,
      // selectedIndex: selectedIndex,
      // animationCurve: Curves.bounceIn,
      // animationDuration: const Duration(seconds: 2),
      // ),
    

      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       label: 'Home',
      //       icon: Icon(Icons.home),
      //     ),
      //     BottomNavigationBarItem(
      //       label: 'Book Store',
      //       icon: Icon(Icons.shopping_bag),
      //     ),
      //     BottomNavigationBarItem(
      //       label: 'Library',
      //       icon: Icon(Boxicons.bx_library),
      //     )
      //   ],
      //   currentIndex: selectedIndex,
      // ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   // animationDuration: Duration(seconds: 2),
      //   // animationCurve: ,
      //   // buttonBackgroundColor: Color.fromARGB(255, 104, 175, 107),
      //   color: Colors.white,
      //   backgroundColor:CostumColor().costum_color,
      //   // height: 15,

      //   // backgroundColor: const Color.fromARGB(255, 104, 175, 107),

      //   onTap: onTapedItems,
      //   items: navigationItems,
      // ),
    );
  }

  List navigationItems=[
    const Icon(Icons.home),
    const Icon(Icons.shopping_bag),
    const Icon(Boxicons.bx_library),
    const Icon(Icons.person)
  ];
}
