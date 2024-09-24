import 'package:book_app/User/costum_homescreen_details.dart';
import 'package:book_app/User/custom_listview.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';

class AdminViewScreen extends StatelessWidget {
  const AdminViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          style: CostumFontStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400).getFontstyle(),
          'Admin'),
          // actions: [
          //   MenuBar(children: )
          // ],
      ),
      body:  Scrollbar(
        radius: const Radius.circular(10),
        thickness: 4,

        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                        decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey)
                      
                      
                      
              ),
              labelText: 'Search',
              suffixIcon: const Icon(Icons.search),
              
                        ),
                      ),
            ),
            const SizedBox(height: 20,),

          
            const CostumHomescreenDetails(title: 'Want to Read', imagePath:'Asset/Fiction_books_1_image_1.jpg' ,isAdmin: true,),
            const SizedBox(height: 30,),
            Container(
                      height: 300,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, -3),
                            blurRadius: 25,
                            // spreadRadius: 3,
                          )
                        ],
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                    style: CostumFontStyle(color: Colors.black, fontSize:20, fontWeight: FontWeight.bold).getFontstyle(),
                                    'Genres'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 200,
                            child: InkWell(
                              child: CustomListview(scrollDirection: Axis.horizontal,isAdmin: true,)
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 30,),

               const CostumHomescreenDetails(title: 'Most Readed Books', imagePath: 'Asset/Fiction_books_1_image_1.jpg',isAdmin: true,)
                    
          
            
          
          
          
          
          ],),
        ),
      ),
    );
  }
}