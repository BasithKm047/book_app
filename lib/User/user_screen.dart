// ignore_for_file: avoid_print

import 'dart:io';

import 'package:book_app/User/navigator_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  TextEditingController _usernameController=TextEditingController();
  final _formkey=GlobalKey<FormState>();
  File? _image;
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
                      : const AssetImage(
                        'Asset/download_1.jpeg'),
                  
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
                        
                      controller: _usernameController,
                      decoration: InputDecoration(

                        border:  OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: CostumColor().costum_color)),
                          enabledBorder: const OutlineInputBorder(

                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 104, 175, 107),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10))),
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
                            if(value==null||_usernameController.text.isEmpty){
                              return 'Enter a name';
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
                      style:   ElevatedButton.styleFrom(
                        backgroundColor: CostumColor().costum_color,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                          
                        )
                        ),
                        onPressed: (){
                          if(_formkey.currentState!.validate()){
                           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const NavigatorScreen(),));
                          }else{
                            // ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                            //   backgroundColor: CostumColor().costum_color_3,
                            //   content: Text(
                            //   style: CostumFontStyle(color: CostumColor().costum_color, fontSize: 15, fontWeight: FontWeight.w400).getFontstyle(),
                            //   'Enter a name')));
                          }
                          
                        
                      }, child: Text('Log in',
                      style: CostumFontStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400).getFontstyle(),)),
                    ),
                  ),
                  const SizedBox(height: 10,)
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
}
