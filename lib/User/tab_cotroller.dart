import 'package:book_app/User/author_sreen.dart';
import 'package:book_app/User/bookstore_screen.dart';
import 'package:book_app/User/language_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:flutter/material.dart';

class TabcontrollerScreen extends StatelessWidget {
  const TabcontrollerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          bottom: TabBar(
            labelColor: CostumColor().costum_color_1,
            automaticIndicatorColorAdjustment: true,
            dividerColor: Colors.white,
            dividerHeight: 0,
            tabs: const [
              Tab(
                
                text:  'Genre ',
                
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
          BookstoreScreen(),
          AuthorSreen(),
          LanguageScreen()
      
        ]),
      ),
    );
  }
}