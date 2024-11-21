import 'dart:convert';
import 'dart:io';

import 'package:book_app/Admin/admin_navigator_screen.dart';
import 'package:book_app/Admin/author_adding_screen.dart';
import 'package:book_app/function/author_db_function.dart';
import 'package:book_app/model/author_model.dart';
import 'package:book_app/util/common_function.dart';
import 'package:book_app/util/costum_textformfield.dart';
import 'package:book_app/function/book_db_function.dart';
import 'package:book_app/function/genres_db_function.dart';
import 'package:book_app/function/language_db_function.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/model/genres_model.dart';
import 'package:book_app/model/language_model.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
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
  TextEditingController _discribtionController = TextEditingController();
  // TextEditingController _totalpageController = TextEditingController();
  final _fomKey = GlobalKey<FormState>();
  List<AuthorModel> authors = [];
  List<GenresModel> genres = [];
  List<LanguageModel> languages = [];
  Uint8List? _webPdfBytes; // For storing picked file bytes on web
  String? _fileName;
  //  dynamic _webImageBytes;
  GenresModel? selectedGenre;
  LanguageModel? selectedLanguage;
  AuthorModel? selectedAuthor;
  Uint8List? _webImageBytes;
  File? _image;
  String? _file_path;
  var pickPdfFilePick = true;
  Future<void> loadAuthors() async {
    // Populate the authors list here, e.g., from a database or API
    authors = await getAllAuthor(); // Example function to fetch authors
    authors = authors.toSet().toList();
    // Set selectedAuthor only if it matches the item in authors
    setState(() {
      selectedAuthor = authors.firstWhere(
          (element) => element.name == widget.bookDetails.authors.name);
    });
  }

  Future<void> loadGenre() async {
    genres = await getAllGenres();
    genres = genres.toSet().toList();

    selectedGenre = genres.isNotEmpty
        ? genres.firstWhere(
            (genre) => genre.name == widget.bookDetails.genre.name,
            orElse: () => GenresModel(1, name: ''),
          )
        : null;
  }

  Future<void> loadLanguage() async {
    languages = await getAllLanguage();
    languages = languages.toSet().toList();
    selectedLanguage = languages.isNotEmpty
        ? languages.firstWhere(
            (language) =>
                language.language == widget.bookDetails.language.language,
            orElse: () => LanguageModel('', 1),
          )
        : null;
  }

  @override
  void initState() {
    super.initState();

    _bookController = TextEditingController(text: widget.bookDetails.bookName);
    // TextEditingController(text: widget.bookDetails.authorName);
    _discribtionController =
        TextEditingController(text: widget.bookDetails.discribtion);
    if (kIsWeb) {
      // If it's a base64-encoded string, decode it

      _webImageBytes = base64Decode(widget.bookDetails.image_path);
    } else {
      // For mobile devices, load the image from the file path
      _image = File(widget.bookDetails.image_path);
    }
    if (kIsWeb) {
      _webPdfBytes=base64Decode( widget.bookDetails.pdf_path);
    }else{
      _file_path=widget.bookDetails.pdf_path;
    }

    loadAuthors();

    loadGenre();
    loadLanguage();
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Form(
                  key: _fomKey,
                  // autovalidateMode: AutovalidateMode.always,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height:
                          ResponsiveHelper(context).getResponsiveHeight(115),
                      width: ResponsiveHelper(context).getResponsiveWidth(90),
                      decoration: BoxDecoration(
                          color: CostumColor().costum_color_4,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          imageBox(_image?.path ?? '', 'Image', getimage),
                          const SizedBox(
                            height: 10,
                          ),
                          CostumTextformfield(
                            title: 'Book name',
                            controller: _bookController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: buttonforAddAuthor('Add Author'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          buildDropdown(
                              valueNotifier: author_modelList,
                              selectedValue: selectedAuthor,
                              hintText: 'Author',
                              emptyText: 'No author found',
                              displayText: (Author) => Author.name,
                              onChanged: (AuthorModel? newAuthor) {
                                setState(() {
                                  selectedAuthor = newAuthor;
                                });
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          buildDropdown(
                              valueNotifier: genremodelList,
                              selectedValue: selectedGenre,
                              hintText: 'Genre',
                              emptyText: 'No Genre found',
                              displayText: (genreName) => genreName.name,
                              onChanged: (GenresModel? newGenre) {
                                setState(() {
                                  selectedGenre = newGenre;
                                });
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          buildDropdown(
                              valueNotifier: languageModelList,
                              selectedValue: selectedLanguage,
                              hintText: 'Language',
                              emptyText: 'No language found',
                              displayText: (language) => language.language,
                              onChanged: (LanguageModel? newLanguage) {
                                setState(() {
                                  selectedLanguage = newLanguage;
                                });
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          discribtionField(
                              validatorText: 'Enter Discribtion',
                              hintText: 'Discribtion',
                              controller: _discribtionController),
                          const SizedBox(
                            height: 10,
                          ),
                          // CostumTextformfield(
                          //     title: 'Total page',
                          //     controller: _totalpageController),
                          const SizedBox(
                            height: 10,
                          ),
                          pickingPdf(
                              text: 'Upload Pdf',
                              filePath: _file_path,
                              pickingPdfCallback: pickPdfFile),
                          const SizedBox(
                            height: 15,
                          ),
                          bookAddingUpdatingButton(
                              buttonText: 'Update',
                              onPressed: updatebook,
                              backgroundColor: CostumColor().costum_color_3,
                              textColor: CostumColor().costum_color_1)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updatebook() async {
    try {
      bool isFormValid = _fomKey.currentState!.validate();

      // List to track missing fields
      List<String> missingFields = [];

      // Check for missing required fields
      if (_image == null && _webImageBytes == null) {
        throw Exception("Image is required");
      }
      if (_file_path == null && _webPdfBytes == null) {
        throw Exception("PDF file is required");
      }

      if (_image == null && _webImageBytes == null) missingFields.add('Image');
      if (_bookController.text.trim().isEmpty) missingFields.add('Name');
      if (_discribtionController.text.trim().isEmpty)
        missingFields.add('Description');
      if (selectedAuthor == null) missingFields.add('Author');
      if (selectedGenre == null) missingFields.add('Genre');
      if (selectedLanguage == null) missingFields.add('Language');
      if (_file_path == null && _webPdfBytes == null) missingFields.add('file');

      // If there are missing fields, show a message and return early
      if (!isFormValid || missingFields.isNotEmpty) {
        String missingFieldsText = missingFields.join(', ');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Please fill in the following fields: $missingFieldsText')));
        return;
      }

      Book updatedBook = widget.bookDetails;
      String imagePath = kIsWeb ? base64Encode(_webImageBytes!) : _image!.path;
      String pdfPath = kIsWeb ? base64Encode(_webPdfBytes!) : _file_path!;
      updatedBook = Book(
        id: widget.bookDetails.id,
        image_path: imagePath,
        bookName: _bookController.text,
        discribtion: _discribtionController.text,
        pdf_path: pdfPath,
        genre: GenresModel(selectedGenre!.id, name: selectedGenre!.name),
        language:
            LanguageModel(selectedLanguage!.language, selectedLanguage!.id),
        authors: AuthorModel(selectedAuthor!.id, selectedAuthor!.name,
            selectedAuthor!.image_path),
        isFavourite: false,
        isWantToRead: false,
        isFinished: false,
        // totalPage: _totalpageController.text.isNotEmpty
        //     ? int.tryParse(_totalpageController.text) ?? 0
        //     : 0,
        newAdded: updatedBook.newAdded,
        isNewReleases: updatedBook.isNewReleases,
      );
      // await newAddedBooks(updatedBook);
      await updateBook(updatedBook);
      Dailogueforlottie(context, 'Book updated successfully');
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => AdminNavigatorScreen(),
      ));
      //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AdminTabcontrollerScreen(),));
    } catch (e) {
      print("Error updating book: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to update book. Please try again.')),
      );
    }
  }

  Future<void> getimage() async {
    if (kIsWeb) {
      final result = await FilePicker.platform
          .pickFiles(type: FileType.image, withData: true);
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _webImageBytes = result.files.first.bytes;
        });
        print('web image is selected');
      } else {
        print('no image is selected');
      }
    } else {
      final selectedimage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (selectedimage == null) return;
      final imageTemborory = File(selectedimage.path);

      setState(() {
        _image = imageTemborory;
      });
    }
  }

  Future<void> pickPdfFile() async {
    try {
      if (kIsWeb) {
        if (kIsWeb) {
          if (_webPdfBytes == null) {
            throw Exception("PDF selection failed on web.");
          }
        } else {
          if (_file_path == null) {
            throw Exception("PDF selection failed on mobile.");
          }
        }

        final result = await FilePicker.platform.pickFiles(
            type: FileType.custom, allowedExtensions: ['pdf'], withData: true);
        if (result != null && result.files.isNotEmpty) {
          setState(() {
            _webImageBytes = result.files.first.bytes;
            _fileName = result.files.first.name;
          });
          print("Selected PDF (Web): $_fileName");
        } else {
          print('no files  selected ');
        }
      } else {
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
    } catch (e) {
      print("Error picking PDF file: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick a PDF file.')),
      );
    }
  }

  Widget imageBox(String? imagePath, String text, Function getimage) {
    return GestureDetector(
      onTap: () {
        getimage();
      },
      child: Container(
        decoration: BoxDecoration(
            image: _image != null
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(File(imagePath!)), // For mobile
                  )
                : _webImageBytes != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(_webImageBytes!), // For web
                      )
                    : null,
            color: CostumColor().costum_color_3,
            borderRadius: BorderRadius.circular(10)),
        height: ResponsiveHelper(context).getResponsiveHeight(22),
        width: ResponsiveHelper(context).getResponsiveWidth(35),
        child: _image == null && _webImageBytes == null
            ? Center(
                child: Text(
                    style: CostumFontStyle(
                            color: CostumColor().costum_color_1,
                            fontSize: 15,
                            fontWeight: FontWeight.normal)
                        .getFontstyle_2(),
                    text),
              )
            : null,
      ),
    );
  }

  Widget buttonforAddAuthor(String text) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(ResponsiveHelper(context).getResponsiveWidth(90),
                ResponsiveHelper(context).getResponsiveHeight(7)),
            shape: RoundedRectangleBorder(
                // side: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            backgroundColor: CostumColor().costum_color_3),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AuthorAddingScreen(),
          ));
        },
        child: Text(
            style: CostumFontStyle(
                    color: Colors.white,
                    fontSize:
                        ResponsiveHelper(context).getResponsiveFontSize(4),
                    fontWeight: FontWeight.w400)
                .getFontstyle_2(),
            text));
  }

  Widget buildDropdown<T>({
    required ValueNotifier<List<T>> valueNotifier,
    required T? selectedValue,
    required String hintText,
    required String emptyText,
    required String Function(T)
        displayText, // function to get display text from model
    required void Function(T?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        decoration: BoxDecoration(
          color: CostumColor().costum_color_3,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ValueListenableBuilder<List<T>>(
          valueListenable: valueNotifier,
          builder: (context, List<T> items, child) {
            if (items.isEmpty) {
              return Center(
                child: Text(emptyText),
              );
            }
            return DropdownButtonFormField<T>(
              decoration: InputDecoration(
                  hintStyle: CostumFontStyle(
                    color: CostumColor().costum_color_1,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ).getFontstyle_2(),
                  hintText: hintText,
                  fillColor: selectedValue == null
                      ? CostumColor().costum_color_1
                      : CostumColor().costum_color_3,
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.only(left: 15, top: 10, bottom: 20)),
              isExpanded: true,
              value: selectedValue,
              items: items.map((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(
                      style: CostumFontStyle(
                              color: CostumColor().costum_color_3,
                              fontSize: 15,
                              fontWeight: FontWeight.w500)
                          .getFontstyle_2(),
                      displayText(value)),
                );
              }).toList(),
              onChanged: onChanged,
              style: TextStyle(color: CostumColor().costum_color_1),
              selectedItemBuilder: (BuildContext context) {
                return items.map<Widget>((T value) {
                  return Container(
                    color: CostumColor()
                        .costum_color_3, // Color of the field when an item is selected
                    child: Text(
                      displayText(value),
                      style: CostumFontStyle(
                        color: Colors.white, // Change text color if needed
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ).getFontstyle_2(),
                    ),
                  );
                }).toList();
              },
            );
          },
        ),
      ),
    );
  }

  Widget discribtionField(
      {required String validatorText,
      required String hintText,
      required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: ResponsiveHelper(context).getResponsiveHeight(20),
        width: ResponsiveHelper(context).getResponsiveWidth(90),
        decoration: BoxDecoration(
          color: CostumColor().costum_color_3,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          style: CostumFontStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.normal)
              .getFontstyle_2(),
          validator: (value) {
            if (value == null && value!.trim().isEmpty) {
              return 'Enter Discribtion';
            } else if (!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(value)) {
              // Allowing spaces in description
              return 'Only letters, numbers, and spaces are allowed';
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
                      color: CostumColor().costum_color_1,
                      fontSize: 15,
                      fontWeight: FontWeight.normal)
                  .getFontstyle_2(),
              fillColor: CostumColor().costum_color_1,
              contentPadding: const EdgeInsets.all(15)),
          // inputFormatters: [
          //    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
          // ],
        ),
      ),
    );
  }

  Widget pickingPdf({
    required String text,
    required String? filePath,
    required VoidCallback pickingPdfCallback,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: pickingPdfCallback,
        child: Container(
          decoration: BoxDecoration(
            color: CostumColor().costum_color_3,
            // border: Border.all(color: CostumColor().costum_color_2, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: pickingPdfCallback,
                  icon: (filePath != null && _webPdfBytes != null)
                      ? const Icon(Icons.check, color: Colors.green)
                      : const Icon(Icons.upload, color: Colors.white),
                ),
              ),
              Text(
                text,
                style: CostumFontStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ).getFontstyle_2(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bookAddingUpdatingButton({
    required String buttonText,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return SizedBox(
      height: 50,
      width: 120,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            color: textColor,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
