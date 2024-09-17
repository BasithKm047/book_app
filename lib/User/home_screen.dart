import 'package:book_app/User/costum_card.dart';
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
          leading: const CircleAvatar(backgroundColor: Colors.amber,),
          title: Text(style: GoogleFonts.lora(), "Home"),
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
                Container(
                  height: 350,
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
                                'Want to Read'),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon:
                                  const Icon(Icons.arrow_forward_ios_outlined))
                        ],
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      SizedBox(
                        height: 220,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 8),
                          child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
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
                                        onTap: () {},
                                        child: Image.asset(
                                            fit: BoxFit.cover,
                                            'Asset/Fiction_books_1_image_1.jpg'),
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
                ),
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
                          onTap: (){},
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return const CostumCard(
                                  title: 'Fiction', 
                                  imagePath: 'Asset/book_image_2.jpg');
                                
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: 5),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  height: 350,
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
                        height: 30,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                                style: GoogleFonts.lora(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                'Most Readed Books'),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon:
                                  const Icon(Icons.arrow_forward_ios_outlined))
                        ],
                      ),
                     
                      SizedBox(
                        height: 220,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 8),
                          child: GestureDetector(
                            onTap: (){},
                            child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      width: 10,
                                    ),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                       
                                        ),
                                    width: 150,
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Image.asset(
                                              fit: BoxFit.cover,
                                              'Asset/Fiction_books_1_image_1.jpg'),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
