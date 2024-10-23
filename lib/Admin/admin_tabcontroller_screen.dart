import 'package:book_app/Admin/admin_author_screen.dart';
import 'package:book_app/Admin/admin_genre_screen.dart';
import 'package:book_app/Admin/admin_languge_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:flutter/material.dart';

class AdminTabcontrollerScreen extends StatelessWidget {
  const AdminTabcontrollerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          bottom: TabBar(
            labelColor: CostumColor().costum_color,
            automaticIndicatorColorAdjustment: true,
            dividerColor: Colors.white,
            dividerHeight: 0,
            tabs: const [
              Tab(
                text: 'Genre ',
              ),
              Tab(
                text: 'Author',
              ),
              Tab(
                text: 'Langauge',
              )
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: const TabBarView(children: [
          AdminGenreScreen(),
          AdminAuthorScreen(),
          AdminLangugeScreen(),
        ]),
      ),
    );
  }
}
