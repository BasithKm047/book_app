import 'package:book_app/Admin/admin_login_screen.dart';
import 'package:book_app/User/costum_homescreen_details.dart';
import 'package:book_app/User/custom_listview.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.amber,
            ),
          ),
          title: Text(style: GoogleFonts.lora(), "Home"),
          actions: [
            IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder:(context) => const AdminLoginScreen(),));
            }, icon:const Icon(
              size: 30.0,
              color:Colors.grey,
              Icons.admin_panel_settings))
          ],
        ),
        body: Scrollbar(
          thickness: 4,
          radius: const Radius.circular(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              style: GoogleFonts.lora(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                              ),
                              'Hi User'),
                          Text(
                              style: GoogleFonts.lora(
                                fontWeight: FontWeight.w400,
                                color: CostumColor().costum_color,
                              ),
                              'What you want to read today?')
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const CostumHomescreenDetails(title: 'Want to Read',imagePath: 'Asset/Fiction_books_1_image_1.jpg',),
                const SizedBox(
                  height: 30,
                ),
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
                                style: GoogleFonts.lora(
                                    // color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                'More to Explore'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 200,
                        child: InkWell(
                          child: CustomListview(scrollDirection: Axis.horizontal,)
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
               const CostumHomescreenDetails(title: 'Most Readed Books', imagePath: 'Asset/Fiction_books_1_image_1.jpg')
              ],
            ),
          ),
        ));
  }
}
