import 'package:book_app/User/catogories_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

// ignore: must_be_immutable
class CostumGrid extends StatelessWidget {
  final bool isAdmin;

   CostumGrid({super.key,  required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 16,
        // mainAxisExtent: 4,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return  Column(
          children: [
            InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CatogoriesScreen(title: catagories[index], isAdmin: isAdmin),)),
              child: Card(
                elevation: 5,
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: CostumColor().costum_color_3
                  ),
              
                  child:  Center(child: Text(
                    style: CostumFontStyle(color: CostumColor().costum_color_1, fontSize: 15, fontWeight: FontWeight.normal).getFontstyle(),
                    catagories[index]),),
                  
                  
                ),
              ),
            ),
           if(isAdmin==true)
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
           Padding(
             padding: const EdgeInsets.only(left: 10.0),
             child: IconButton(onPressed: (){
              //delete the catogory
             }, icon: const Icon(
              // size: 10,
              color: Color.fromARGB(255, 228, 45, 32),
              Icons.delete )),
           ),
          

           
           Padding(
             padding: const EdgeInsets.only(right: 10),
             child: IconButton(onPressed: (){
             //edit the catogory
             },
              icon: const Icon(
                // size: 10,
              color: Color.fromARGB(255, 38, 37, 37),
              Boxicons.bx_edit),),
           )
            ],
           ),
         

            
          ],
        );

      },
      itemCount: 6,
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
