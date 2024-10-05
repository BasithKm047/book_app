import 'package:book_app/Admin/genre_update_screen.dart';
import 'package:book_app/User/catogories_screen.dart';
import 'package:book_app/function/genres_db_function.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class CostumGrid extends StatefulWidget {
  final bool isAdmin;

  CostumGrid({super.key, required this.isAdmin});

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
        if(value.isEmpty){
          return const Center(child: Text('Genres not found'),);
        }

        return  GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 16,
                // mainAxisExtent: 4,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final genre=value[index];
                return Column(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CatogoriesScreen(
                            title: genre.name, isAdmin: widget.isAdmin),
                      )),
                      child: Card(
                        elevation: 5,
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              color: CostumColor().costum_color_3),
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
                                onPressed: () async{
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
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => GenreUpdatScreen(genre: genre),));
                                // updateGeners(genre);
                              },
                              icon: const Icon(
                                  // size: 10,
                                  color: Color.fromARGB(255, 38, 37, 37),
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
          } 
           
    );
        
      
        
    
           
  }
}
