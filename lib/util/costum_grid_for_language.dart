
import 'package:book_app/Admin/language_updating_screen.dart';
import 'package:book_app/User/catogories_screen.dart';
import 'package:book_app/function/language_db_function.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class CostumGridForLanguage extends StatefulWidget {
  final bool isAdmin;

  CostumGridForLanguage({super.key, required this.isAdmin});

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
                childAspectRatio: .8,
                crossAxisSpacing: 16,
                // mainAxisExtent: 4,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final language = value[index];
                return Column(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CatogoriesScreen(
                            title: language.language, isAdmin: widget.isAdmin,isLanguage: true,),
                      )),
                      child: Card(
                        elevation: 10,
                        child: Container(
                          height:
                              ResponsiveHelper(context).getResponsiveHeight(13),
                          width:
                              ResponsiveHelper(context).getResponsiveWidth(50),
                          decoration: BoxDecoration(
                            // image: DecorationImage(
                            //   fit: BoxFit.cover,
                            //   image: FileImage(

                            //     File(
                            //       value[index].image_path != null
                            //           ? value[index].image_path!
                            //           : '')),
                            // ),
                            color: CostumColor().costum_color,
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
                                onPressed: () async {
                                  //delete the catogory
                                  await deleteLanguage(language);
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
