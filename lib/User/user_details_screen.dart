import 'dart:io';

import 'package:book_app/User/welcome_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserDetailsScreen extends StatelessWidget {
  final String ?image_path;
  final String ?name;
  const UserDetailsScreen({super.key,  this.image_path, this.name});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(title: Text(
        style: CostumFontStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400).getFontstyle(),
        'Account'),
        ),
        body:  Column(
          children:  [
            const SizedBox(height: 30,),
            Container(
            
                    height: ResponsiveHelper(context).getResponsiveHeight(50),
                    width: ResponsiveHelper(context).getResponsiveWidth(95),
                    decoration: BoxDecoration(
                      color: CostumColor().costum_color_3,
                      
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.c,
                      children: [
                          const SizedBox(height: 20,),
            
                        SizedBox(
                          height: ResponsiveHelper(context).getResponsiveHeight(10),
                          width: ResponsiveHelper(context).getResponsiveWidth(30),
                          child: CircleAvatar(
                            backgroundImage: FileImage(
                              
                              File(image_path!)),
                          ),
                        
                        
                        ),
                        const SizedBox(width: 20,),
                        Text(name!)
                       
                      ],
                    ),
            ),
            ElevatedButton(onPressed: (){
              _logoutuser(context);

            }, child: const Text('Logout'))

          ],

        ),
    );
  }
   Future<void> _logoutuser(BuildContext context) async {
    final adminBox = Hive.box('user');
    await adminBox.put('isLoggedin', false); // Mark admin as logged out

    // Navigate back to the login screen
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const WelcomeScreen(),
    ));
  }

}