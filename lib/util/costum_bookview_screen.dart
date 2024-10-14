  import 'dart:io';

  import 'package:book_app/User/book_reader_screen.dart';
  import 'package:book_app/function/book_db_function.dart';
  import 'package:book_app/util/costum_color.dart';
  import 'package:book_app/util/font_style.dart';
  import 'package:flutter/material.dart';

  class CostumBookviewScreen extends StatefulWidget {
    final String name;
  
    
    const CostumBookviewScreen({super.key, required this.name,   });

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
        body: ValueListenableBuilder(
          valueListenable: bookListnotifier,
          builder: (context, bookList, child) {
            final bookDetails = bookList.firstWhere(
                (book) => book.bookName == widget.name,
                ); 

            
            
          return  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 230,
                width: 130,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      fit: BoxFit.cover,
                      File(bookDetails.image_path)
                      ),
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
                  isFavourite ?ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: CostumColor().costum_color_1,
          
                    content:Text(
                      style: CostumFontStyle(fontSize: 15, fontWeight: FontWeight.normal,color: CostumColor().costum_color).getFontstyle(),
                      'Added to Favourite'))):null;
          
          
                  }, icon: isFavourite?const Icon(color: Colors.red, Icons.favorite):const Icon(color: Colors.red, Icons.favorite_border_outlined),
                    ),
          
                  IconButton(onPressed: (){
                    setState(() {
                      isAdd=!isAdd;
                    });

                    //add the book to want to read 
                  
                  isAdd?ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: CostumColor().costum_color_1,
          
                      content: Text(
                        style: CostumFontStyle(fontSize: 15, fontWeight: FontWeight.normal,color:CostumColor().costum_color).getFontstyle(),
                        'Added to Want to Read'))):null;
                  }, 
                  icon: isAdd? const Icon(Icons.done): const Icon(Icons.add))
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
                      
                      bookDetails.authorName),
                      const SizedBox(height: 10,),
                      Expanded(
                        child: Text(
                          style: CostumFontStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.normal).getFontstyle_2(),
                          bookDetails.discribtion),
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
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  BookReaderScreen( pdf_path: bookDetails.pdf_path,),));
                
                
                }, child:  Text(
                  style: CostumFontStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.normal).getFontstyle(),
                  'Read')),
              ),
          
            ],
          );
          },
          
        ),
      );
    }
  }
