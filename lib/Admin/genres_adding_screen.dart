import 'dart:io';

import 'package:book_app/function/genres_db_function.dart';
import 'package:book_app/model/genres_model.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class GenresAddingScreen extends StatefulWidget {
  const GenresAddingScreen({super.key});

  @override
  State<GenresAddingScreen> createState() => _GenresAddingScreenState();
}

class _GenresAddingScreenState extends State<GenresAddingScreen> {
  File? _image;
  final TextEditingController _genersController = TextEditingController();
  @override
  void dispose() {
    _genersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
            style: CostumFontStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400)
                .getFontstyle(),
            'Manage Genres'),
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
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z]')), // Restrict to letters only
                ],
                controller: _genersController,
                decoration: InputDecoration(
                    isDense: true,
                    hintStyle: CostumFontStyle(
                            color: CostumColor().costum_color_3,
                            fontSize: 15,
                            fontWeight: FontWeight.normal)
                        .getFontstyle_2(),
                    hintText: 'Genres',
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
                genresAdding();
              },
              child: Text(
                  style: CostumFontStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.normal)
                      .getFontstyle_2(),
                  'Save'))
        ],
      ),
    );
  }

  Future<void> genresAdding() async {
    String genrName = _genersController.text.trim();

    if (genrName.isNotEmpty) {
      int newId = DateTime.now().millisecondsSinceEpoch % 0xFFFFFFFF;
      GenresModel newgenre = GenresModel(
        newId,
        name: genrName,
        
      );

      try {
        await addGenres(newgenre);
        _genersController.clear();
        Navigator.of(context).pop();
        print('Genre added succesfully');
      } catch (e) {
        print('Error adding genre :$e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: CostumColor().costum_color_3,
          content: Text(
              style: CostumFontStyle(
                      color: CostumColor().costum_color_1,
                      fontSize: 15,
                      fontWeight: FontWeight.w400)
                  .getFontstyle_2(),
              'Please enter a Genre name')));
    }
  }

  Future<void> getimage() async {
    final selectedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedimage == null) return;
    final imageTemborory = File(selectedimage.path);

    setState(() {
      _image = imageTemborory;
    });
  }
}
