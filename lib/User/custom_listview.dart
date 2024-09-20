import 'package:book_app/User/catogories_screen.dart';
import 'package:book_app/User/costum_card.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomListview extends StatelessWidget {
  final Axis scrollDirection ;
   CustomListview({super.key, required this.scrollDirection});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ListView.separated(
        scrollDirection: scrollDirection,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  CatogoriesScreen(title: catagories[index],),));
                  },
                  child: CostumCard(title: catagories[index], imagePath:  'Asset/book_image_2.jpg'));
              },
              itemCount: 5,
              separatorBuilder: (context, index) => const Divider(
                thickness: 1,
                color: Colors.blueGrey,
              ),
            ),
          
    );
  }
   List catagories=[
    'Fiction',
    'Science',
    'Non Fiction',
    'Thriller',
    'Romance',
    'Fantacy',

  ];
}