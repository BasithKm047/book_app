import 'dart:io';

import 'package:book_app/User/welcome_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AdminDetailsScreen extends StatefulWidget {
  final String? name;
  final String? image_path;
  const AdminDetailsScreen({super.key, this.name, this.image_path});

  @override
  State<AdminDetailsScreen> createState() => _AdminDetailsScreenState();
}

class _AdminDetailsScreenState extends State<AdminDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text(
          style: CostumFontStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400).getFontstyle(),
          'Account'),
        // leading: CircleAvatar(
        //   backgroundImage: FileImage(File(widget.image_path??'Asset/download_1.jpeg')),
        // ),
      ),
      body:
      
          Column(
            children: [
               const SizedBox(height: 50,),
            
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
                              
                              File(widget.image_path??'')),
                          ),
                        
                        
                        ),
                        const SizedBox(height: 30,),
                        Text(
                          style: CostumFontStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400).getFontstyle(),
                          widget.name??'')
                       
                      ],
                    ),
            ),
              const SizedBox(height: 100,),

              ElevatedButton(
                  onPressed: () {
                    _logoutAdmin(context);
                  },
                  child: const Text('Logout')),
            ],
          ),
    );
  }

  //   Future<bool> _handleBackButtonPress(BuildContext context) async {
  Future<void> _logoutAdmin(BuildContext context) async {
    final adminBox = Hive.box('Admin');
    await adminBox.put('isLoggedin', false); // Mark admin as logged out

    // Navigate back to the login screen
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const WelcomeScreen(),
    ));
  }
}



  // ElevatedButton(onPressed: (){
              //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CostumSettingScreen(),));

              // }, child: const Text('Settings'),),