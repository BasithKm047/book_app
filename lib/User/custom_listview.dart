import 'package:book_app/User/catogories_screen.dart';
import 'package:book_app/User/costum_card.dart';
import 'package:book_app/function/genres_db_function.dart';
import 'package:book_app/model/genres_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomListview extends StatelessWidget {
  final Axis scrollDirection ;
  final bool isAdmin;
   CustomListview({super.key, required this.scrollDirection, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    getAllGenres();
    return Scaffold(
      body:  ValueListenableBuilder<List<GenresModel>>(
        valueListenable: genremodelList,
        builder: (context, value, child) {
          return ListView.separated(
          scrollDirection: scrollDirection,
                itemBuilder: (context, index) {
                  final genre=value[index];
                  return InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  CatogoriesScreen(title: genre.name, isAdmin: isAdmin,),));
                    },
                    child: CostumCard(title: genre.name, imagePath:  'Asset/book_image_2.jpg'));
                },
                itemCount: value.length,
                separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                  color: Colors.blueGrey,
                ),
              );
        },
         
      ),
          
    );
  }
   
}