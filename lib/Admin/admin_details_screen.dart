import 'dart:io';

import 'package:book_app/Admin/userwanted_booklist_screen.dart';
import 'package:book_app/function/admin_db_function.dart';
import 'package:book_app/function/requestbook_db_function.dart';
import 'package:book_app/model/admin_model.dart';
import 'package:book_app/util/common_function.dart';
import 'package:book_app/util/services.dart';
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
  AdminModel? admin;
  // bool _isLoading = true;
  // Future<void> loadAdminDetails() async {
  //   final adminList = await getAllAdmin();
  //   print("Admin List Loaded: $adminList");
  //   if (adminList.isNotEmpty) {
  //     admin = adminList.last;
  //   }
  //   setState(() {
  //     _isLoading = false;
  //     print("Loading Complete: $_isLoading");
  //   });
  // }

  @override
  void initState() {
    super.initState();
    getAdmindetails();
  }

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
              child: ValueListenableBuilder(
                valueListenable: adminListNotifier,
                builder: (context, adminList, child) {
                  if(adminList.isEmpty){
                    return Center(child: Text('No admins Available',
                    style: CostumFontStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal).getFontstyle(),),);
                  }
                  final adminLast=adminList.last;

                   return Container(
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
                            backgroundImage: adminLast.image_path == null
                                ? const AssetImage('Asset/download_1.jpeg')
                                : FileImage(File(adminLast.image_path))
                                    ),
                      ),
                      Text(
                          style: CostumFontStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)
                              .getFontstyle(),
                          adminLast.name)
                    ],
                  ),
                );
                },
              
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const BuildUserWantedBooks(),
          const SizedBox(
            height: 20,
          ),
          buildLogoutButton(context),
        ],
      ),
    );
  }
  Widget buildLogoutButton(BuildContext context){
   return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: CostumColor().costum_color_3),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return alertDialogForLogout(
                        context: context,
                        itemDetails: context,
                        deleteFunction: _logoutAdmin);
                  },
                );
              },
              child: Text(
                  style: CostumFontStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.normal)
                      .getFontstyle(),
                  'Logout'));
  }

  //   Future<bool> _handleBackButtonPress(BuildContext context) async {
  Future<void> _logoutAdmin(BuildContext context) async {
    final adminBox = Hive.box(adminServices);
    await adminBox.put('isLoggedin', false); // Mark admin as logged out

    // Navigate back to the login screen
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const WelcomeScreen(),
    ));
  }
}

class BuildUserWantedBooks extends StatelessWidget {
  const BuildUserWantedBooks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

