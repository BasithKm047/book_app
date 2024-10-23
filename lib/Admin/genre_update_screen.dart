import 'dart:io';

import 'package:book_app/function/genres_db_function.dart';
import 'package:book_app/model/genres_model.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class GenreUpdatScreen extends StatefulWidget {
  final GenresModel genre;
  const GenreUpdatScreen({super.key, required this.genre});

  @override
  State<GenreUpdatScreen> createState() => _GenreUpdatScreenState();
}

class _GenreUpdatScreenState extends State<GenreUpdatScreen> {
  File? _image;
  late TextEditingController _nameController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.genre.name);
    _image=File(widget.genre.image_path!);
    // widget.genre;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  Future<void> updateGenre() async {
    final updateGenre = GenresModel(widget.genre.id,_image!.path,
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
          Container(
            height: ResponsiveHelper(context).getResponsiveHeight(20),
            width: ResponsiveHelper(context).getResponsiveWidth(40),
            decoration: BoxDecoration(
              color: CostumColor().costum_color_2,
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {
                getimage();
              },
              icon: _image != null && _image!.path.isNotEmpty
                  ? Image.file(
                      fit: BoxFit.cover,
                      File(_image!.path),
                    )
                  : const Icon(
                      size: 50,
                      Icons.add_a_photo_outlined,
                    ),
            ),
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
