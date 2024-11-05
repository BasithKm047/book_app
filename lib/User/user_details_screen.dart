import 'dart:io';

import 'package:book_app/util/welcome_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

  ValueNotifier<List<String>>Books=ValueNotifier([]);

class UserDetailsScreen extends StatelessWidget {
  final String? image_path;
  final String? name;
  const UserDetailsScreen({super.key, this.image_path, this.name});

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
          const SizedBox(width: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                height: ResponsiveHelper(context).getResponsiveHeight(13),
                width: ResponsiveHelper(context).getResponsiveWidth(85),
                decoration: BoxDecoration(
                  color: CostumColor().costum_color_3,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: ResponsiveHelper(context).getResponsiveHeight(9),
                      width: ResponsiveHelper(context).getResponsiveWidth(30),
                    
                      child: CircleAvatar(
                        
                              backgroundImage: image_path == null
                                  ? const AssetImage('Asset/download_1.jpeg')
                                  : FileImage(File(image_path!)),
                            ),
                    ),
                    Text(
                      style: CostumFontStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold).getFontstyle(),
                       name!=null?
                       name!:'User'
                      )
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
                borderRadius: BorderRadius.circular(5)
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CostumColor().costum_color_3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                ),
                onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RequestBook(),));
                }, child:  Text(
                  style: CostumFontStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.normal).getFontstyle(),
                  'Request a Book')),
            ),
          
          const SizedBox(height: 20,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: CostumColor().costum_color_3
            ),
              onPressed: () {
                _logoutuser(context);
              },
              child:  Text(
                style: CostumFontStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.normal).getFontstyle(),
                'Logout'))
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

class RequestBook extends StatefulWidget {
  const RequestBook({super.key});

  @override
  State<RequestBook> createState() => _RequestBookState();
}

class _RequestBookState extends State<RequestBook> {
  TextEditingController _bookName=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Request a book',
          style: CostumFontStyle(color: Colors.white, fontSize:18, fontWeight: FontWeight.bold).getFontstyle(),
          ),
        ),
        body:  Column(
          children: [
             const SizedBox(height: 50,),
               Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  color: CostumColor().costum_color_2,
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z]')), // Restrict to letters only
                ],
                controller: _bookName,
                decoration: InputDecoration(
                    isDense: true,
                    hintStyle: CostumFontStyle(
                            color: CostumColor().costum_color_3,
                            fontSize: 15,
                            fontWeight: FontWeight.normal)
                        .getFontstyle_2(),
                    hintText: 'Request a book',
                    fillColor: CostumColor().costum_color_2,
                    // border: OutlineInputBorder(
                    //     // gapPadding: 10,

                    //     borderRadius: BorderRadius.circular(10)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10)),
              ),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CostumColor().costum_color,
                elevation: 5,
              ),
              onPressed: () {
                requestBook();
              },
              child: Text(
                  style: CostumFontStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.normal)
                      .getFontstyle_2(),
                  'Request'))
          ],
        ),
      ),
    );
  }
  Future<void>requestBook()async{
    _bookName.text.toLowerCase();
    Books.value.add(_bookName.text);
    Books.notifyListeners();
    Navigator.of(context).pop();
    
  }
}
