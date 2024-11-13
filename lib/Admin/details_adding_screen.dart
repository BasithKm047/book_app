import 'dart:io';

import 'package:book_app/Admin/admin_navigator_screen.dart';
import 'package:book_app/Admin/admin_tabcontroller_screen.dart';
import 'package:book_app/Admin/author_adding_screen.dart';
import 'package:book_app/Admin/genres_adding_screen.dart';
import 'package:book_app/Admin/language_adding_screen.dart';
import 'package:book_app/util/costum_textformfield.dart';
import 'package:book_app/function/author_db_function.dart';
import 'package:book_app/function/book_db_function.dart';
import 'package:book_app/function/genres_db_function.dart';
import 'package:book_app/function/language_db_function.dart';
import 'package:book_app/model/author_model.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/model/genres_model.dart';
import 'package:book_app/model/language_model.dart';
import 'package:book_app/util/common_function.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class DetailsAddingScreen extends StatefulWidget {
  DetailsAddingScreen({
    super.key,
  });

  @override
  State<DetailsAddingScreen> createState() => _DetailsAddingScreenState();
}

class _DetailsAddingScreenState extends State<DetailsAddingScreen> {
  final TextEditingController _bookController = TextEditingController();
  final TextEditingController _discribtionController = TextEditingController();
  // final TextEditingController _totalpageController = TextEditingController();
  bool autoValidate=false;
  final _fomKey = GlobalKey<FormState>();
  bool _submitted = false;

  GenresModel? selectedGenre;
  LanguageModel? selectedLanguage;
  AuthorModel? selectedAuthor;

  File? _image;
  String? _file_path;
  var pickPdfFiles = true;

  

  @override
  void initState() {
    getAllGenres();
    super.initState();
    getAllLanguage();
    getAllAuthor();
  }

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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              buttonField: 'Author',
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
                              buttonField: 'Genre',
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
                              buttonField: 'Language',
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
                              buttonText: 'Save',
                              onPressed: bookAdding,
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
                    image: FileImage(File(imagePath!)),
                  )
                : null,
            color: CostumColor().costum_color_3,
            borderRadius: BorderRadius.circular(10)),
        height: ResponsiveHelper(context).getResponsiveHeight(22),
        width: ResponsiveHelper(context).getResponsiveWidth(35),
        child: _image == null
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

  Widget buildDropdown<T>(
      {required ValueNotifier<List<T>> valueNotifier,
      required T? selectedValue,
      required String hintText,
      required String emptyText,
      required String Function(T)
          displayText, // function to get display text from model
      required void Function(T?) onChanged,
      required String buttonField}) {
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
              return GestureDetector(
                onTap: () {
                  // print('HIhih$buttonField');
                  if (buttonField == 'Author') {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AuthorAddingScreen(),
                    ));
                  } else if (buttonField == 'Genre') {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const GenresAddingScreen(),
                    ));
                  } else if (buttonField == 'Language') {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LanguageAddingScreen(),
                    ));
                  }
                },
                child: SizedBox(
                  height: ResponsiveHelper(context).getResponsiveHeight(8.5),
                  width: ResponsiveHelper(context).getResponsiveWidth(80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            style: CostumFontStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal)
                                .getFontstyle(),
                            emptyText),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            style: CostumFontStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal)
                                .getFontstyle(),
                            'Add $buttonField?'),
                      )
                    ],
                  ),
                ),
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
            if (value == null || value.trim().isEmpty) {
              return 'Enter Discribtion';
            } else if (!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(value)) {
              // Allowing spaces in description
              return 'Only letters, numbers, and spaces are allowed';
            }
            return null;
          },
          autovalidateMode:   _submitted? AutovalidateMode.always: AutovalidateMode.disabled,
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
                  icon: filePath != null
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

  Future<void> bookAdding() async {
    // Explicitly validate the form using the _formKey
    bool isFormValid = _fomKey.currentState!.validate();
    setState(() {
      _submitted=true;
    });
    // List to track missing fields

    List<String> missingFields = [];

    // Check for missing required fields
    if (_image == null) missingFields.add('Image');
    if (_bookController.text.trim().isEmpty) missingFields.add('Name');
    if (_discribtionController.text.trim().isEmpty)
      missingFields.add('Description');
      // if(_totalpageController.text.isEmpty)missingFields.add('Totalpage');
    if (selectedAuthor == null) missingFields.add('Author');
    if (selectedGenre == null) missingFields.add('Genre');
    if (selectedLanguage == null) missingFields.add('Language');
    if (_file_path == null) missingFields.add('file');

    // If there are missing fields, show a message and return early
    if (!isFormValid || missingFields.isNotEmpty) {
      String missingFieldsText = missingFields.join(', ');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Please fill in the following fields: $missingFieldsText')));
      return;
    }

    // Proceed with adding the book as all required fields are filled
    int newid = createUniqueId();

    final newBook = Book(
      id: newid,
      image_path: _image!.path,
      bookName: _bookController.text,
      discribtion: _discribtionController.text,
      pdf_path: _file_path!,
      genre: GenresModel(selectedGenre!.id, name: selectedGenre!.name),
      language: LanguageModel(selectedLanguage!.language, selectedLanguage!.id),
      authors: AuthorModel(
        selectedAuthor!.id,
        selectedAuthor!.name,
        selectedAuthor!.image_path,
      ),
      isFavourite: false,
      isWantToRead: false,
      isFinished: false,

    //   totalPage:  _totalpageController.text.isNotEmpty 
    // ? int.tryParse(_totalpageController.text) ?? 0 
    // : 0,
    newAdded: DateTime.now(),
    isNewReleases: true,

  


    );
     await newAddedBooks(newBook);

     await addBook(newBook);
      Dailogueforlottie(context,'Book added successfully');
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AdminNavigatorScreen(),));
  }
}
