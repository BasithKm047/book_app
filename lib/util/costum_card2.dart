import 'package:book_app/User/bookstore_screen.dart';
import 'package:book_app/util/card_1.dart';
import 'package:book_app/function/genres_db_function.dart';
import 'package:book_app/model/genres_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Costumcard2 extends StatelessWidget {

  final bool isAdmin;
  Costumcard2(
      {super.key,  required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    getAllGenres();
    return ValueListenableBuilder<List<GenresModel>>(
      valueListenable: genremodelList,
      builder: (context, value, child) {

        return Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BookstoreScreen(),));
              },
              child: Card1(
                name: genreSample[0],image_path: images[0],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BookstoreScreen(),));
              },
              child: Card1(
                name: genreSample[1],image_path: images[1],
              ),
            ),
          ],
        );

        // return ListView.separated(
        // scrollDirection: scrollDirection,
        //       itemBuilder: (context, index) {
        //         final genre=value[index];
        //         return InkWell(
        //           onTap: (){
        //             Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  CatogoriesScreen(title: genre.name, isAdmin: isAdmin,),));
        //           },
        //           child: CostumCard(title: genre.name, imagePath:  'Asset/book_image_2.jpg'));
        //       },
        //       itemCount: 2,
        //       separatorBuilder: (context, index) => const SizedBox(
        //         // thickness: 1,
        //         // color: Colors.blueGrey,
        //       ),
        //     );
      },
    );
  }

  List images = [
         'Asset/download_4.jpg',
        'Asset/downloads_3.jpg'
  ];
  List genreSample=[
    'Fiction',
    'Non Fiction'

  ];

}
