import 'package:book_app/Admin/genre_update_screen.dart';
import 'package:book_app/User/catogories_screen.dart';
import 'package:book_app/function/genres_db_function.dart';
import 'package:book_app/util/common_function.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class CostumGrid extends StatefulWidget {
  final bool isAdmin;
  final bool isGenre;

  CostumGrid({super.key, required this.isAdmin, required this.isGenre});

  @override
  State<CostumGrid> createState() => _CostumGridState();
}

class _CostumGridState extends State<CostumGrid> {
  @override
  void initState() {
    super.initState();
    getAllGenres();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
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
              childAspectRatio: .9,
              crossAxisSpacing: 16,
              // mainAxisExtent: 4,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              final genre = value[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CatogoriesScreen(
                        title: genre.name,
                        isAdmin: widget.isAdmin,
                        isLanguage: false,
                        isAUthor: false,
                        isGenre: widget.isGenre,
                      ),
                    )),
                    child: Card(
                      elevation: 10,
                      child: Container(
                        height:
                            ResponsiveHelper(context).getResponsiveHeight(10),
                        width: ResponsiveHelper(context).getResponsiveWidth(40),
                        decoration: BoxDecoration(
                            // image: DecorationImage(
                            //   fit: BoxFit.cover,
                            //   image: FileImage(

                            //     File(
                            //       value[index].image_path != null
                            //           ? value[index].image_path!
                            //           : '')),
                            // ),
                            color: CostumColor().costum_color_4,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                              style: CostumFontStyle(
                                      color: CostumColor().costum_color_1,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)
                                  .getFontstyle(),
                              genre.name),
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
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return alertDialogForDelete(
                                        context: context,
                                        itemDetails: genre,
                                        itemType: genre.name,
                                        deleteFunction: deletGenres);
                                  },
                                );
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
