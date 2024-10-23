import 'package:book_app/Admin/genres_adding_screen.dart';
import 'package:book_app/util/costum_grid.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:flutter/material.dart';

class AdminGenreScreen extends StatelessWidget {
  const AdminGenreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CostumGrid(isAdmin: true),
      ),
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
    );
  }
}
