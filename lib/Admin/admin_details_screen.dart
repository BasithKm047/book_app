import 'dart:io';

import 'package:book_app/User/welcome_screen.dart';
import 'package:book_app/util/costum_setting_screen.dart';
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
        title: Text(widget.name??'Basith'),
        leading: CircleAvatar(
          backgroundImage: FileImage(File(widget.image_path??'Asset/download_1.jpeg')),
        ),
      ),
      body:
      
          Column(
            children: [
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CostumSettingScreen(),));

              }, child: const Text('Settings'),),

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
