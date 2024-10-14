import 'dart:io';

import 'package:book_app/Admin/genre_update_screen.dart';
import 'package:book_app/function/genres_db_function.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class CostumRoundedGrid extends StatefulWidget {
  final bool isAdmin;
  
  const CostumRoundedGrid({super.key, required this.isAdmin});

  @override
  State<CostumRoundedGrid> createState() => _CostumRoundedGridState();
}

class _CostumRoundedGridState extends State<CostumRoundedGrid> {
  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(
        valueListenable: genremodelList,
        builder: (context, value, child) {
          if (value.isEmpty) {
            return const Center(
              child: Text('Genres not found'),
            );
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .8,
              crossAxisSpacing: 16,
              // mainAxisExtent: 4,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              final genre = value[index];
              return Column(
                children: [
                  InkWell(
                    // onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => CatogoriesScreen(
                    //       ),
                    // )),
                    child: Container(
                      height:
                          ResponsiveHelper(context).getResponsiveHeight(15),
                      width: ResponsiveHelper(context).getResponsiveWidth(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              
                              File(
                                value[index].image_path != null
                                    ? value[index].image_path!
                                    : '')),
                          ),
                          color: CostumColor().costum_color_2),
                      child: const SizedBox(
                        width: 5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    height: ResponsiveHelper(context).getResponsiveHeight(5),
                    width: ResponsiveHelper(context).getResponsiveWidth(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: CostumColor().costum_color
                    ),
                    child:  Text(
                      textAlign: TextAlign.center,
                     style: CostumFontStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400).getFontstyle(),
                      'author name'),
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
                                await deletGenres(genre);
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
                                    GenreUpdatScreen(genre: genre),
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
          );
        });
  }
}