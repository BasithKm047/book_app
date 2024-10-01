import 'package:book_app/function/genres_db_function.dart';
import 'package:book_app/model/genres_model.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';

class GenreUpdatScreen extends StatefulWidget {
  final GenresModel genre;
  const GenreUpdatScreen({super.key, required this.genre});

  @override
  State<GenreUpdatScreen> createState() => _GenreUpdatScreenState();
}

class _GenreUpdatScreenState extends State<GenreUpdatScreen> {
  late TextEditingController _nameController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.genre.name);
    // widget.genre;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  Future<void> updateGenre() async {
    final updateGenre = GenresModel( widget.genre.id,
        name: _nameController.text);
    await updateGeners(updateGenre);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            style: CostumFontStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400)
                .getFontstyle(),
            'Update Genres'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  color: CostumColor().costum_color_2,
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    isDense: true,
                    hintStyle: CostumFontStyle(
                            color: CostumColor().costum_color_3,
                            fontSize: 15,
                            fontWeight: FontWeight.normal)
                        .getFontstyle_2(),
                    hintText: 'Genre Name',
                    fillColor: CostumColor().costum_color_2,
                    // border: OutlineInputBorder(
                    //     // gapPadding: 10,

                    //     borderRadius: BorderRadius.circular(10)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10)),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CostumColor().costum_color,
                elevation: 5,
              ),
              onPressed: () {
                updateGenre();
              },
              child: Text(
                  style: CostumFontStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.normal)
                      .getFontstyle_2(),
                  'Update'))
        ],
      ),
    );
  }
}
