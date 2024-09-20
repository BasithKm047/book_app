import 'package:book_app/User/book_reader_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';

class CostumBookviewScreen extends StatefulWidget {
  final String name;
  final String imagePath;
   const CostumBookviewScreen({super.key, required this.name, required this.imagePath, });

  @override
  State<CostumBookviewScreen> createState() => _CostumBookviewScreenState();
}

class _CostumBookviewScreenState extends State<CostumBookviewScreen> {
  var isFavourite=false;
  var isAdd=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
            style: CostumFontStyle(fontSize: 20, fontWeight: FontWeight.w400,color: Colors.black)
                .getFontstyle(),
            widget.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 230,
            width: 130,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  fit: BoxFit.cover,
                  widget.imagePath),
                  ),
            ),
          
          
          ),
      
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {
                
               setState(() {
                 isFavourite=!isFavourite;
                 
               });

               //add the book to favourite screen
              !isFavourite ?ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: CostumColor().costum_color_1,

                content:Text(
                  style: CostumFontStyle(fontSize: 15, fontWeight: FontWeight.normal,color: CostumColor().costum_color).getFontstyle(),
                  'Added to Favourite'))):null;


              }, icon: isFavourite?const Icon(color: Colors.red, Icons.favorite_outline):const Icon(color: Colors.red, Icons.favorite),
                ),

              IconButton(onPressed: (){
                //add the book to want to read 
               
               !isAdd?ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: CostumColor().costum_color_1,

                  content: Text(
                    style: CostumFontStyle(fontSize: 15, fontWeight: FontWeight.normal,color:CostumColor().costum_color).getFontstyle(),
                    'Added to Want to Read'))):null;
              }, 
              icon: const Icon(Icons.add))
            ],
          ),
          const SizedBox(height: 10,),
          Container(
            height: 250,
            width: 300,
            decoration: BoxDecoration(
            color: const Color.fromARGB(255, 176, 175, 175),
            borderRadius: BorderRadius.circular(20)

            ),
            child: Column(
              children: [
                const SizedBox(height: 10,),
                Text(
                  style: CostumFontStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.normal).getFontstyle(),
                  
                  'Author name'),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child: Text(
                        style: CostumFontStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.normal).getFontstyle_2(),
                        'Book discribtion......................................................................................'),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Container(
            width: 300,
            decoration: const BoxDecoration(
              // shape: BoxShape.rectangle,
              // borderRadius: BorderRadius.circular(10)
              // color: CostumColor().costum_color,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CostumColor().costum_color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
              ),
              
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookReaderScreen(),));
            
            
            }, child:  Text(
              style: CostumFontStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.normal).getFontstyle(),
              'Read')),
          ),

        ],
      ),
    );
  }
}
