import 'package:book_app/Admin/admin_navigator_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          style: CostumFontStyle(fontSize: 23.0,fontWeight: FontWeight.normal,color: Colors.black).getFontstyle(),
           'Log in'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      style: CostumFontStyle( fontSize: 20,fontWeight: FontWeight.w400,color: Colors.black).getFontstyle(),
                    
                      'Are you admin?'),
                  ],
                ),
              ),
              SizedBox(
                height: 500,
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  shadowColor:
                      const Color.fromARGB(255, 104, 175, 107).withOpacity(1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Form(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 370,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30.0,
                              ),
                              SizedBox(
                                child: Image.asset(
                                    height: 170,
                                    width: 170,
                                    'Asset/book_image_1.jpeg'),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      autovalidateMode: AutovalidateMode.always,
                                
                                      decoration:  InputDecoration(
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: CostumColor().costum_color,
                                                width: 1,
                                              ),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(10))),
                                          labelText: 'User name',
                                          labelStyle: const TextStyle(
                                            fontSize: 13.0,
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                            vertical: 10.0,
                                            horizontal: 15.0,
                                          )),
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   height: 10.0,
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      obscureText: true,
                                      
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 104, 175, 107),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          labelText: 'Password',
                                          labelStyle: TextStyle(
                                            fontSize: 13.0,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 10.0,
                                            horizontal: 15.0,
                                          )),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 50.0,
                              width: double.infinity,
                              decoration: const BoxDecoration(),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminNavigatorScreen(),));

                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      shadowColor: Colors.black,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0))),
                                      backgroundColor: const Color.fromARGB(
                                          255, 104, 175, 107)),
                                  child: const Text(
                                      style: TextStyle(color: Colors.white),
                                      'Log in'))),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
