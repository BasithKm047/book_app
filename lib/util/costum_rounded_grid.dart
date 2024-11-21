import 'dart:convert';
import 'dart:io';

import 'package:book_app/Admin/author_updating_screen.dart';
import 'package:book_app/util/catogories_screen.dart';
import 'package:book_app/function/author_db_function.dart';
import 'package:book_app/util/common_function.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class CostumRoundedGrid extends StatefulWidget {
  final bool isAdmin;
  final bool isAUthor;
  const  CostumRoundedGrid({super.key, required this.isAdmin, required this.isAUthor});

  @override
  State<CostumRoundedGrid> createState() => _CostumRoundedGridState();
}


class _CostumRoundedGridState extends State<CostumRoundedGrid> {
  @override
  void initState() {
    super.initState();
    getAllAuthor();
  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: author_modelList,
        builder: (context, value, child) {
          if (value.isEmpty) {
            return const Center(
              child: Text('Author not found'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: kIsWeb? 1.3: .7,
                crossAxisSpacing: kIsWeb?500: 16,
                // mainAxisExtent: 4,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final author = value[index];
                return Column(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CatogoriesScreen(
                          title: author.name,
                          isAdmin: widget.isAdmin,
                          isLanguage: false,
                          isAUthor: widget.isAUthor,
                          isGenre: widget.isAUthor,
                         
                            ),
                      )),
                      child: Container(
                        height: 
                        kIsWeb? ResponsiveHelper(context).getResponsiveHeight(40):
                            ResponsiveHelper(context).getResponsiveHeight(15),

                        width:kIsWeb? ResponsiveHelper(context).getResponsiveWidth(20):
                         ResponsiveHelper(context).getResponsiveWidth(31),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image:
                            !kIsWeb? DecorationImage(
                              fit: BoxFit.cover,
                              image:
                               FileImage(File(author.image_path)),
                            ):
                            DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(base64Decode(author.image_path))),
                            color: CostumColor().costum_color_2),
                        child: const SizedBox(
                          width: 10,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: ResponsiveHelper(context).getResponsiveHeight(5),
                      width: ResponsiveHelper(context).getResponsiveWidth(40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CostumColor().costum_color_4),
                      child: Center(
                        child: Text(
                            textAlign: TextAlign.center,
                            style: CostumFontStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400)
                                .getFontstyle(),
                            author.name),
                      ),
                    ),
                    if (widget.isAdmin == true)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: IconButton(
                                onPressed: ()  {
                                  //delete the catogory
                                  showDialog(context: context, builder: (context) {
                                    return alertDialogForDelete(context: context, itemDetails: author, itemType: author.name, deleteFunction: deleteAuthor);
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
                                      AuthorUpdatingScreen(author: author)
                                ));
                                // updateGeners(genre);
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
