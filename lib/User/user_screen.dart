// ignore_for_file: avoid_print

import 'dart:io';

import 'package:book_app/User/navigator_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:book_app/util/services.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  TextEditingController _usernameController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  File? _image;
  @override
  // void initState() {
  //   super.initState();
  //   getAllUser();
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ResponsiveHelper(context).getResponsiveHeight(60),
      width: double.infinity,
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formkey,
        child: Card(
          color: CostumColor().costum_color_3,
          elevation: 10,
          shadowColor: const Color.fromARGB(255, 104, 175, 107).withOpacity(1),
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
                  maxRadius: 60,
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
                      style: TextStyle(
                        color: CostumColor().costum_color_1,
                      ),
                      controller: _usernameController,
                      decoration: InputDecoration(
                          focusColor: CostumColor().costum_color,
                          // errorBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(
                          //         color: CostumColor().costum_color)),
                          border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: CostumColor().costum_color)),
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
                          )),
                      validator: (value) {
                        if (value == null || _usernameController.text.isEmpty) {
                          return 'Enter name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: ResponsiveHelper(context).getResponsiveHeight(7),
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
  Future<void> _setLoginStatus(bool status) async {
    final adminBox = await Hive.openBox('user');
    await adminBox.put('isLoggedin', status);
  }

  Future<void> login() async {
    if (!_formkey.currentState!.validate()) {
      _showErrorDialog('Please add userame');
      
    }
    if(_image==null){
        _showErrorDialog('Please add an image');
      }
    else{
        try {
    // Try logging in with the provided credentials
    bool isLoggedIn = await Services().userLogin(
      _usernameController.text
    );

    // If login is successful, navigate to the next screen
    if (isLoggedIn) {
      await _setLoginStatus(true); // Store the login status
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => NavigatorScreen(
            image_path: _image!.path,
             userName: _usernameController.text,
          ),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      // If login fails, show an error message
      _showErrorDialog('Invalid Username or Password');
    }
  } catch (e) {
    // Catch any other errors and show an error message
    _showErrorDialog('An unexpected error occurred. Please try again.');
  } finally {
    // Stop loading in both success and error cases
    // setState(() => _isLoading = false);
  }

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
