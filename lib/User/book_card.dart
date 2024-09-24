import 'package:book_app/User/costum_bookview_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class BookCard extends StatefulWidget {
  String title;
  String imagePath;
  Icon? icon;
  Icon?icon_2;
  final bool isAdmin;
   BookCard({super.key,required this.title,required this.imagePath ,this.icon, this.icon_2,required this.isAdmin});

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SizedBox(
            height: 180,
            width: 150,
            // color: Colors.amber,
            child:  ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CostumBookviewScreen(name: 'Book Name', imagePath: 'Asset/Fiction_books_1_image_1.jpg'),));
              },
              child: Image.asset(widget.imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,),
            ),
          ),
          ),

         
          const SizedBox(height: 10,),
         Container(
           height: 40,
           width: 150.0,
           decoration: BoxDecoration(
             color: CostumColor().costum_color,
             borderRadius: BorderRadius.circular(20)
           ),
           child: Align(
             alignment: Alignment.center,
             child: Text(
               style: GoogleFonts.lora(
                 // fontSize: ,
                 fontWeight: FontWeight.w400,
                 color: Colors.white,
               ),
               widget.title),
         
         
           )),


           if(widget.isAdmin==true)
           

           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.icon!=null?
           Padding(
             padding: const EdgeInsets.only(left: 10.0),
             child: IconButton(onPressed: (){
              //delete the book
             }, icon: Icon(
              // size: 10,
              color: const Color.fromARGB(255, 228, 45, 32),
              widget.icon!.icon)),
           )
           :const SizedBox.shrink(),

           widget.icon_2!=null?
           Padding(
             padding: const EdgeInsets.only(right: 10),
             child: IconButton(onPressed: (){
             //edit the book
             },
              icon: Icon(
                // size: 10,
              color: const Color.fromARGB(255, 38, 37, 37),
              widget.icon_2!.icon),),
           )
           :const SizedBox.shrink(),
            ],
           ),
           

          // Icon(Icons.abc_sharp),




         
        ],
      
      ),
    );
  }
}


