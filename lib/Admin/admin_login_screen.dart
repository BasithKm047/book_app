import 'dart:developer';
import 'dart:io';

import 'package:book_app/Admin/admin_navigator_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  TextEditingController _password_controller = TextEditingController();
  TextEditingController _adminNameController = TextEditingController();
  final String Username = 'basith';
  final String Password = '1234';

  final _formkey = GlobalKey<FormState>();

  File? _image;
  @override
  void initState() {
    super.initState();
    loadData();

  }

  void loadData()async{
   await checkLoggedInStatus();

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: ResponsiveHelper(context).getResponsiveHeight(60),
        width: double.infinity,
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formkey,
          child: Card(
            color: CostumColor().costum_color_3,
            elevation: 10,
            shadowColor:
                const Color.fromARGB(255, 104, 175, 107).withOpacity(1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: CircleAvatar(
                    // color: Colors.amber,
                    maxRadius: 50,
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : const AssetImage('Asset/download_1.jpeg'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: _adminNameController,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 104, 175, 107),
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: 'User name',
                          labelStyle: CostumFontStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400)
                              .getFontstyle(),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 15.0,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        obscureText: true,
                        controller: _password_controller,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 104, 175, 107),
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: 'Password',
                          labelStyle: CostumFontStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400)
                              .getFontstyle(),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 15.0,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter password';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height:
                            ResponsiveHelper(context).getResponsiveHeight(7),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: CostumColor().costum_color,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            onPressed: () {
                              login();
                            },
                            child: Text(
                              'Log in',
                              style: CostumFontStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)
                                  .getFontstyle(),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getImage() async {
    final selectedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (selectedimage == null) {
      print("No image selected.");
      return;
    }

    final imageTemporary = File(selectedimage.path);

    print("Image selected: ${imageTemporary.path}");

    setState(() {
      _image = imageTemporary;
    });
  }

  Future<void> checkLoggedInStatus() async {
    final admin = await Hive.openBox('Admin');
    final isLoggedIn = admin.get('isLoggedin', defaultValue: false);

    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => AdminNavigatorScreen(
          image_path: _image?.path ?? '',
          name: _adminNameController.text,
        ),
      ));
      log('mesAdminNavigatorScreen');
    } 
  }

  void login() {
    String enteredUsername = _adminNameController.text.trim().toLowerCase();
    String enteredPassword = _password_controller.text.trim();
    if (_formkey.currentState!.validate() &&
        enteredPassword == Password &&
        enteredUsername == Username) {
      final admin = Hive.box('Admin');
      admin.put('isLoggedin', true);

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) => AdminNavigatorScreen(
          image_path: _image?.path ?? '',
          name: _adminNameController.text,
        ),
      ),
      (Route<dynamic> route) => false,
      );
    } else {
      print('not ok');
      _showErrorDialog('Invalid Username or Password');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: CostumColor().costum_color_4,
          title: Text(
              style: CostumFontStyle(
                      color: CostumColor().costum_color,
                      fontSize: 10,
                      fontWeight: FontWeight.w400)
                  .getFontstyle(),
              'Error'),
          content: Text(
              style: CostumFontStyle(
                      color: CostumColor().costum_color,
                      fontSize: 10,
                      fontWeight: FontWeight.w400)
                  .getFontstyle(),
              message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                  style: CostumFontStyle(
                          color: CostumColor().costum_color,
                          fontSize: 15,
                          fontWeight: FontWeight.w400)
                      .getFontstyle(),
                  'OK'),
            ),
          ],
        );
      },
    );
  }
}
