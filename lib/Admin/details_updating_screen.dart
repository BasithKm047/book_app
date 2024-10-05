import 'dart:io';

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

class DetailsUpdatingScreen extends StatefulWidget {
  final Book bookDetails;
  const DetailsUpdatingScreen({super.key, required this.bookDetails});

  @override
  State<DetailsUpdatingScreen> createState() => _DetailsUpdatingScreenState();
}

class _DetailsUpdatingScreenState extends State<DetailsUpdatingScreen> {
  TextEditingController _bookController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _discribtionController = TextEditingController();
  final _fomKey = GlobalKey<FormState>();

  GenresModel? selectedGenre;

  File? _image;
  String? _file_path;
  var pickPdfFilePick = true;

  @override
  void initState() {
    getBooksByGenre(widget.bookDetails.genre.name);
    super.initState();
    _bookController = TextEditingController(text: widget.bookDetails.bookName);
    _nameController =
        TextEditingController(text: widget.bookDetails.authorName);
    _discribtionController =
        TextEditingController(text: widget.bookDetails.discribtion);
    _image = File(widget.bookDetails.image_path);
    
    
  }
  //  void didUpdateWidget(covariant DetailsUpdatingScreen oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (oldWidget.bookDetails != widget.bookDetails) {
  //     // Reinitialize the fields when the book changes
  //     _initializeFields();
  //   }
  // }

  // void _initializeFields() {
  //   _bookController.text = widget.bookDetails.bookName;
  //   _nameController.text = widget.bookDetails.authorName;
  //   _discribtionController.text = widget.bookDetails.discribtion;
  //   _image = File(widget.bookDetails.image_path); // Load existing image
  //   _file_path = widget.bookDetails.pdf_path; // Load existing PDF
  //   // Set the current genre
  //   selectedGenre = widget.bookDetails.genre;
  // }

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
                                  value: value, child: Text(value.name));
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
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        hintText: 'Discribtion',
                        hintStyle: CostumFontStyle(
                                color: CostumColor().costum_color_3,
                                fontSize: 15,
                                fontWeight: FontWeight.normal)
                            .getFontstyle_2()),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20.0),
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
                            icon: const Icon(Icons.upload),
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
                      // bookAdding();
                      updatebook();
                      Navigator.of(context).pop();
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
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
                        'Update'),
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

        Future<void> updatebook() async {
  if (!_fomKey.currentState!.validate()) {
    return;
  }

  if (_image == null || _file_path == null || selectedGenre == null) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields.')));
    return;
  }

  final updatedBook = Book(
    _bookController.text,
    _discribtionController.text,
    _nameController.text,
    widget.bookDetails.id, // Keep the original ID
    _image!.path,
    _file_path!,
    GenresModel(selectedGenre!.id, name: selectedGenre!.name),
  );

  await updateBook(updatedBook); // Your function to update the book in the database
  Navigator.pop(context); // Go back after updating
}



      

    // if (!_fomKey.currentState!.validate()) {
    //   if (_image == null || _file_path==null || selectedGenre == null) {
    //     String missingField = '';
    //     if (_image == null) missingField = 'Image';
    //     if (_file_path == null) missingField = 'File';
    //     if (selectedGenre == null) missingField = 'Genre';

    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(SnackBar(content: Text('Fill the $missingField')));
    //     return;
    //   }
     
    // }else{
    //    int newid = DateTime.now().microsecondsSinceEpoch % 0xFFFFFFFF;
    //   final newBook = Book(
    //       _bookController.text,
    //       _discribtionController.text,
    //       _nameController.text,
    //       newid,
    //       _image!.path,
    //       _file_path!,
    //       GenresModel(selectedGenre!.id, name: selectedGenre!.name));
    //   await addBook(newBook);
    // }\
    
    
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

  

}