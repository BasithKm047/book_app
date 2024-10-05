import 'dart:io';

import 'package:book_app/Admin/admin_genre_screen.dart';
import 'package:book_app/Admin/costum_textformfield.dart';
import 'package:book_app/function/book_db_function.dart';
import 'package:book_app/function/genres_db_function.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/model/genres_model.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailsAddingScreen extends StatefulWidget {
  const DetailsAddingScreen({
    super.key,
  });

  @override
  State<DetailsAddingScreen> createState() => _DetailsAddingScreenState();
}

class _DetailsAddingScreenState extends State<DetailsAddingScreen> {
  final TextEditingController _bookController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _discribtionController = TextEditingController();
  final _fomKey = GlobalKey<FormState>();

  GenresModel? selectedGenre;

  File? _image;
  String? _file_path;
  var pickPdfFiles = true;

  @override
  void initState() {
    getAllGenres();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Form(
            key: _fomKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: GestureDetector(
                    onTap: () {
                      getimage();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          image: _image != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(_image!),
                                )
                              : null,
                          color: CostumColor().costum_color_2,
                          borderRadius: BorderRadius.circular(10)),
                      height: 200,
                      width: 200,
                      child: _image == null
                          ? Center(
                              child: Text(
                                  style: CostumFontStyle(
                                          color: CostumColor().costum_color_3,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal)
                                      .getFontstyle_2(),
                                  'Image'),
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CostumTextformfield(
                  title: 'Book name',
                  controller: _bookController,
                ),
                const SizedBox(
                  height: 15,
                ),
                CostumTextformfield(
                  controller: _nameController,
                  title: 'Author name',
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                      decoration: BoxDecoration(
                          color: CostumColor().costum_color_2,
                          borderRadius: BorderRadius.circular(10)),
                      child: ValueListenableBuilder(
                        valueListenable: genremodelList,
                        builder: (context, List<GenresModel> genre, child) {
                          if (genre.isEmpty) {
                            return const Center(
                              child: Text('No Genres '),
                            );
                          }
                          return DropdownButtonFormField(
                            onTap: () {},
                            decoration: InputDecoration(
                              hintStyle: CostumFontStyle(
                                      color: CostumColor().costum_color_3,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)
                                  .getFontstyle_2(),
                              hintText: 'Genres',
                              fillColor: CostumColor().costum_color_3,
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(10),

                              // ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                            ),
                            isExpanded: true,
                            value: selectedGenre,
                            items: genre.map((value) {
                              return DropdownMenuItem(
                                  onTap: () {
                                    // getBooksByGenre(selectedGenre!.name);
                                  },
                                  value: value,
                                  child: Text(value.name));
                            }).toList(),
                            onChanged: (GenresModel? newgenre) {
                              setState(() {
                                selectedGenre = newgenre;
                              });
                            },
                          );
                        },
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    color: CostumColor().costum_color_2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Discribtion';
                      }
                      return null;
                    },
                    controller: _discribtionController,
                    onTap: () {},
                    maxLines: null,
                    expands: true,
                    
                    // keyboardType
                    
                    decoration: InputDecoration(
                      border: InputBorder.none,
                        hintText: 'Discribtion',
                        hintStyle: CostumFontStyle(
                                color: CostumColor().costum_color_3,
                                fontSize: 15,
                                fontWeight: FontWeight.normal)
                            .getFontstyle_2(),
                            
                            ),
          //                    inputFormatters: [
          //               FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')), 
          // ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      pickPdfFile();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: CostumColor().costum_color_2, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                              onPressed: () {
                                pickPdfFile();
                                
                              },
                               icon: _file_path!= null
                        ? const Icon(Icons.check, color: Colors.green)  // Show done icon if PDF is picked
                        : const Icon(Icons.upload),
                              // icon: const Icon(Icons.upload),
                            ),
                          ),
                          Text(
                              style: CostumFontStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)
                                  .getFontstyle_2(),
                              'Add Pdf')
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: CostumColor().costum_color,
                    ),
                    onPressed: () {
                      bookAdding();
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => const AdminGenreScreen(),
                      // ));

                      // save data
                    },
                    child: Text(
                        style: CostumFontStyle(
                                color: CostumColor().costum_color_1,
                                fontSize: 15,
                                fontWeight: FontWeight.w400)
                            .getFontstyle(),
                        'Save'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
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

  Future<void> pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      // print('selected file:${file.name}');
      print('File path:${file.path} File added');
      setState(() {
        _file_path = result.paths.first;
      });
    } else {
      print('No File Selected');
    
    }
  }

  Future<void> bookAdding() async {
    if (!_fomKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all text fields')));
      return;
    }

    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an image')));
      return;
    }

    if (_file_path == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please upload a PDF file')));
      return;
    }

    if (selectedGenre == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please select a genre')));
      return;
    }

    int newid = DateTime.now().microsecondsSinceEpoch % 0xFFFFFFFF;
    final newBook = Book(
        _bookController.text,
        _discribtionController.text,
        _nameController.text,
        newid,
        _image!.path,
        _file_path!,
        GenresModel(selectedGenre!.id, name: selectedGenre!.name));

    await addBook(newBook);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Book Added Successful')));
    // await getBooksByGenre(selectedGenre!.name);

    Navigator.of(context).pushReplacement(
      
      MaterialPageRoute(builder: (context) => const AdminGenreScreen()),
    );

    //   if (!_fomKey.currentState!.validate()) {
    //     if (_image == null || !pickPdfFiles || selectedGenre == null) {
    //       String missingField = '';
    //       if (_image == null) missingField = 'Image';
    //       if (_file_path == null) missingField = 'File';
    //       if (selectedGenre == null) missingField = 'Genre';

    //       ScaffoldMessenger.of(context)
    //           .showSnackBar(SnackBar(content: Text('Fill the $missingField')));
    //       return;
    //     }
    //     int newid = DateTime.now().microsecondsSinceEpoch % 0xFFFFFFFF;
    //     final newBook = Book(
    //         _bookController.text,
    //         _discribtionController.text,
    //         _nameController.text,
    //         newid,
    //         _image!.path,
    //         _file_path!,
    //         GenresModel(name: selectedGenre!.name, newid));
    //     await addBook(newBook);
    //   }
  }
}
