import 'package:book_app/Admin/language_updating_screen.dart';
import 'package:book_app/util/catogories_screen.dart';
import 'package:book_app/function/language_db_function.dart';
import 'package:book_app/util/common_function.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class CostumGridForLanguage extends StatefulWidget {
  final bool isAdmin;
  final bool isLanguage;

  CostumGridForLanguage({
    super.key,
    required this.isAdmin,
    required this.isLanguage,
  });

  @override
  State<CostumGridForLanguage> createState() => _CostumGridForLanguageState();
}

class _CostumGridForLanguageState extends State<CostumGridForLanguage> {
  @override
  void initState() {
    super.initState();
    getAllLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: languageModelList,
        builder: (context, value, child) {
          if (value.isEmpty) {
            return const Center(
              child: Text('Language  not found'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final language = value[index];
                return Column(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CatogoriesScreen(
                          title: language.language,
                          isAdmin: widget.isAdmin,
                          isLanguage: widget.isLanguage,
                          isAUthor: false,
                          isGenre: false,
                         
                        ),
                      )),
                      child: Card(
                        elevation: 10,
                        child: Container(
                          height:
                              ResponsiveHelper(context).getResponsiveHeight(10),
                          width:
                              ResponsiveHelper(context).getResponsiveWidth(40),
                          decoration: BoxDecoration(
                            color: CostumColor().costum_color_4,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                                style: CostumFontStyle(
                                        color: CostumColor().costum_color_1,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal)
                                    .getFontstyle(),
                                language.language),
                          ),
                        ),
                      ),
                    ),
                    if (widget.isAdmin == true)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: IconButton(
                                onPressed: () {
                                  //delete the catogory
                                  showDialog(context: context, builder: (context) {
                                    return  alertDialogForDelete(
                                      context: context,
                                      itemDetails: language,
                                      itemType: language.language,
                                      deleteFunction: deleteLanguage);
                                  },);
                                 
                                },
                                icon: const Icon(
                                    // size: 10,
                                    color: Color.fromARGB(255, 228, 45, 32),
                                    Icons.delete)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: IconButton(
                              onPressed: () {
                                //edit the catogory
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        LanguageUpdatingScreen(
                                            language: language)));
                              },
                              icon: Icon(
                                  // size: 10,
                                  color: CostumColor().costum_color_1,
                                  Boxicons.bx_edit),
                            ),
                          )
                        ],
                      ),
                  ],
                );
              },
              itemCount: value.length,
            ),
          );
        });
  }
}
