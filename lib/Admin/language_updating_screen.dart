import 'package:book_app/function/language_db_function.dart';
import 'package:book_app/model/language_model.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LanguageUpdatingScreen extends StatefulWidget {
  LanguageModel language;
   LanguageUpdatingScreen({super.key,required this.language});

  @override
  State<LanguageUpdatingScreen> createState() => _LanguageUpdatingScreenState();
}

class _LanguageUpdatingScreenState extends State<LanguageUpdatingScreen> {
  TextEditingController _langugeController=TextEditingController();
  @override
  void initState() {
    super.initState();
    _langugeController=TextEditingController(text: widget.language.language);
  }

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
                updateLanguageToDb();
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
  void updateLanguageToDb(){
    final newLanguage=LanguageModel(_langugeController.text, widget.language.id);
    updateLanguage(newLanguage);
    Navigator.of(context).pop();

       
  }
}