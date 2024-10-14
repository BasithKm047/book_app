import 'package:book_app/Admin/admin_author_screen.dart';
import 'package:book_app/Admin/admin_languge_screen.dart';
import 'package:book_app/Admin/genres_adding_screen.dart';
import 'package:book_app/util/costum_grid.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:flutter/material.dart';

class AdminGenreScreen extends StatelessWidget {
  const AdminGenreScreen({super.key, });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom:  TabBar(

            labelColor: CostumColor().costum_color,
            automaticIndicatorColorAdjustment: true,
            dividerColor: Colors.white,
            dividerHeight: 0,
            tabs:const [
              Tab(
                text: 'Genre ',
              ),
              Tab(
                text: 'Langauge',
              ),
              Tab(
                text: 'Author',
              )
            ],
            indicatorColor: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          // title: Text(
          //   'Genres',
          //   style: CostumFontStyle(
          //           color: Colors.white,
          //           fontSize: 20,
          //           fontWeight: FontWeight.w400)
          //       .getFontstyle(),
          // ),
        ),
        
        body: TabBarView(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: SafeArea(child: CostumGrid(isAdmin: true)),
          ),
          const AdminLangugeScreen(),
           const AdminAuthorScreen(isAdmin: true,),
          
        ]),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: CostumColor().costum_color),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const GenresAddingScreen(),
                ));
              },
              child: Icon(color: CostumColor().costum_color_1, Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}
