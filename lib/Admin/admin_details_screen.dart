import 'dart:io';

import 'package:book_app/User/user_details_screen.dart';
import 'package:book_app/util/welcome_screen.dart';
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
            style: CostumFontStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400)
                .getFontstyle(),
            'Account'),
        // leading: CircleAvatar(
        //   backgroundImage: FileImage(File(widget.image_path??'Asset/download_1.jpeg')),
        // ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                height: ResponsiveHelper(context).getResponsiveHeight(13),
                width: ResponsiveHelper(context).getResponsiveWidth(85),
                decoration: BoxDecoration(
                    color: CostumColor().costum_color_3,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    SizedBox(
                      height: ResponsiveHelper(context).getResponsiveHeight(9),
                      width: ResponsiveHelper(context).getResponsiveWidth(30),
                      child: CircleAvatar(
                        backgroundImage: widget.image_path == null
                            ? const AssetImage('Asset/download_1.jpeg')
                            : FileImage(File(widget.image_path!)),
                      ),
                    ),
                    Text(
                        style: CostumFontStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)
                            .getFontstyle(),
                        widget.name != null ? widget.name! : 'Basith')
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: ResponsiveHelper(context).getResponsiveHeight(7),
            width: ResponsiveHelper(context).getResponsiveWidth(85),
            decoration: BoxDecoration(
                color: CostumColor().costum_color_3,
                borderRadius: BorderRadius.circular(5)),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: CostumColor().costum_color_3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UserWantedBookList()));
                },
                child: Text(
                    style: CostumFontStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal)
                        .getFontstyle(),
                    'User wanted books')),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: CostumColor().costum_color_3),
              onPressed: () {
                _logoutAdmin(context);
              },
              child: Text(
                  style: CostumFontStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.normal)
                      .getFontstyle(),
                  'Logout'))
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

class UserWantedBookList extends StatelessWidget {
  const UserWantedBookList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
        style: CostumFontStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400).getFontstyle(),
        'List of Books'),),
      body: ValueListenableBuilder(
        valueListenable: Books,
        builder: (context, listOfBooks, child) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.separated(
              itemBuilder: (context, index) {
                final book = listOfBooks[index];
                return ListTile(
                  title: Text(
                      style: CostumFontStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.normal)
                          .getFontstyle(),
                      book),
                );
              },
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              ),
              itemCount: listOfBooks.length,
            ),
          );
        },
      ),
    );
  }
}


  // ElevatedButton(onPressed: (){
              //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CostumSettingScreen(),));

              // }, child: const Text('Settings'),),