import 'dart:io';

import 'package:book_app/User/navigator_screen.dart';
import 'package:book_app/User/request_book_screen.dart';
import 'package:book_app/function/requestbook_db_function.dart';
import 'package:book_app/function/user_db_function.dart';
import 'package:book_app/model/requested_book_model.dart';
import 'package:book_app/util/common_function.dart';
import 'package:book_app/util/services.dart';
import 'package:book_app/util/welcome_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';


class UserDetailsScreen extends StatefulWidget {
  final String? image_path;
  final String? name;
  const UserDetailsScreen({super.key, this.image_path, this.name});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  void initState() {
    super.initState();
    getUserdetails();
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
              child: ValueListenableBuilder(
                valueListenable: userList_notifier,
                builder: (context, userList, child) {
                  if (userList.isEmpty) {

                    return Center(
                      child: Text(
                        'No user found',
                        style: CostumFontStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.normal)
                            .getFontstyle(),
                      ),
                    );
                  }
                   final LastUser=userList.last;
                  return Container(
                    height: ResponsiveHelper(context).getResponsiveHeight(13),
                    width: ResponsiveHelper(context).getResponsiveWidth(85),
                    decoration: BoxDecoration(
                        color: CostumColor().costum_color_3,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        SizedBox(
                          height:
                              ResponsiveHelper(context).getResponsiveHeight(9),
                          width:
                              ResponsiveHelper(context).getResponsiveWidth(30),
                          child: CircleAvatar(
                            backgroundImage: LastUser.image_path == null
                                ? const AssetImage('Asset/download_1.jpeg')
                                : FileImage(File(LastUser.image_path)),
                          ),
                        ),
                        Text(
                            style: CostumFontStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)
                                .getFontstyle(),
                            LastUser.username)
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
                    builder: (context) => const RequestBook(),
                  ));
                },
                child: Text(
                    style: CostumFontStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal)
                        .getFontstyle(),
                    'Request a Book')),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: CostumColor().costum_color_3),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return alertDialogForLogout(
                        context: context,
                        itemDetails: context,
                        deleteFunction: _logoutuser);
                  },
                );
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

  Future<void> _logoutuser(BuildContext context) async {
    final adminBox = Hive.box(userServices);
    await adminBox.put('isLoggedin', false); // Mark admin as logged out

    // Navigate back to the login screen
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const WelcomeScreen(),
    ));
  }
}

class RequestBook extends StatefulWidget {
  const RequestBook({super.key});

  @override
  State<RequestBook> createState() => RequestBookState();
}


