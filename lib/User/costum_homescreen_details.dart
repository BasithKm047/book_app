import 'package:book_app/User/catogories_screen.dart';
import 'package:book_app/User/costum_bookview_screen.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';

class CostumHomescreenDetails extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isAdmin;
  const CostumHomescreenDetails({super.key, required this.title, required this.imagePath, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: double.infinity,
      decoration: const BoxDecoration(
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
                    style: CostumFontStyle(
                            fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black)
                        .getFontstyle(),
                    title),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CatogoriesScreen(title: title,isAdmin: isAdmin,),));
                  },
                  icon: const Icon(Icons.arrow_forward_ios_outlined))
            ],
          ),
          SizedBox(
            height: 220,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8),
              child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                  scrollDirection: Axis.horizontal,
                  // scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: const BoxDecoration(
                          // color: Color.fromARGB(255, 142, 137, 137),
                          // borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                      width: 150,
                      // height: 100,
                      // color: const Color.fromARGB(255, 239, 228, 228),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const CostumBookviewScreen(name: 'Book name',imagePath: 'Asset/Fiction_books_1_image_1.jpg',),));
                            },
                            child: Image.asset(
                                fit: BoxFit.cover,
                                imagePath),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 10),
            ),
          ),
        ],
      ),
    );
  }
}
