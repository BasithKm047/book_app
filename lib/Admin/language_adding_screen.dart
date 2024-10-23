import 'package:book_app/function/language_db_function.dart';
import 'package:book_app/model/language_model.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LanguageAddingScreen extends StatefulWidget {
  const LanguageAddingScreen({super.key});

  @override
  State<LanguageAddingScreen> createState() => _LanguageAddingScreenState();
}

class _LanguageAddingScreenState extends State<LanguageAddingScreen> {
  TextEditingController _langugeController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:  Text(
          style: CostumFontStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400).getFontstyle(),
          'Manage Language'),
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
                controller: _langugeController,
                decoration: InputDecoration(
                    isDense: true,
                    hintStyle: CostumFontStyle(
                            color: CostumColor().costum_color_3,
                            fontSize: 15,
                            fontWeight: FontWeight.normal)
                        .getFontstyle_2(),
                    hintText: 'Language',
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
                addLanguageToDb();
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
  void addLanguageToDb()async{
    
    String language = _langugeController.text.trim();

    if (language.isNotEmpty) {
      int newId = DateTime.now().millisecondsSinceEpoch % 0xFFFFFFFF;
      LanguageModel newLanguage = LanguageModel(
        
      language=language,
      newId
      );

      try {
           await addLanguage(newLanguage);
        _langugeController.clear();
        Navigator.of(context).pop();
        print('Language added Successfully');
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
              'Please enter a Language')));
    }
  }
  }
