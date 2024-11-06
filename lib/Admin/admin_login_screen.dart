import 'dart:io';

import 'package:book_app/Admin/admin_navigator_screen.dart';
import 'package:book_app/function/admin_db_function.dart';
import 'package:book_app/model/admin_model.dart';
import 'package:book_app/util/common_function.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:book_app/util/services.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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
   bool _isLoading = false;
  final _formkey = GlobalKey<FormState>();

  File? _image;
  @override
  // void initState() {
  //   super.initState();
    
  //   loadAdminData();
  // }
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
                    backgroundImage:_image!=null?
                         FileImage(_image!):
                         const AssetImage('Asset/download_1.jpeg')
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
                          color: CostumColor().costum_color_1
                        ),
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
                        style: TextStyle(
                          color: CostumColor().costum_color_1,
                        ),
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
                            onPressed:
                             _isLoading? null:_login,
                            child:_isLoading?const CircularProgressIndicator(): Text(
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

  Future<void> _setLoginStatus(bool status) async {
    final adminBox = await Hive.openBox('admin');
    await adminBox.put('isLoggedin', status);
  }

  // Future<void> _login() async {

  //   await _setLoginStatus(true);
    
  //   if (_formkey.currentState!.validate()||_image!=null) {
     
     
  //     setState(() => _isLoading = true); // Start loading

    
  //       bool isLoggedIn = await Services().login(_adminNameController.text, _password_controller.text);
  //       if (isLoggedIn) {
  //         Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(
  //             builder: (context) => AdminNavigatorScreen(
  //               image_path: _image!.path,
  //               name: _adminNameController.text,
  //             ),
  //           ),
  //           (Route<dynamic> route) => false,
  //         );
  //       } 
  //   }else {

  //         _showErrorDialog('Invalid Username or Password');
  //       setState(() => _isLoading = false); // Stop loading

  //       }
     
  //     }
  Future<void> _login() async {
  // First, check if the form is valid and if an image has been selected
  if (!_formkey.currentState!.validate()) {
    // If form is not valid, show an error message and return
    _showErrorDialog('Please fill in all fields correctly.');
    return;
  } 
   if (_image == null) {
    // If image is not selected, show an error message and return
    _showErrorDialog('Please select an image.');
    return;
  }

  // Set loading state to true
  setState(() => _isLoading = true);

  try {
    // Try logging in with the provided credentials
    bool isLoggedIn = await Services().adminlogin(
      _adminNameController.text,
      _password_controller.text,
    );

    // If login is successful, navigate to the next screen
    if (isLoggedIn) {
      await _setLoginStatus(true);
      int newid=createUniqueId();
     final newAdmin=  AdminModel(id: newid, name: _adminNameController.text,image_path: _image!.path);
    await addAdmin(newAdmin);
      // Store the login status
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => AdminNavigatorScreen(
            image_path: _image!.path,
            name: _adminNameController.text,
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
    setState(() => _isLoading = false);
  }
}


//   Future<void> loadAdminData() async {
//   final box = await Hive.openBox('admin_data');
  
//   String? username = box.get('username');
//   String? imagePath = box.get('image');
  
//   if (username != null && imagePath != null) {
//     // Restore the username and image (e.g., set them to your app's UI)
//    // Assuming you're using a File for image
//    setState(() {
//       _adminNameController.text = username;
//     _image = File(imagePath);  
//    });
//   }
// }

  

  // void login() {
  //   String enteredUsername = _adminNameController.text.trim().toLowerCase();
  //   String enteredPassword = _password_controller.text.trim();
  //   if (_formkey.currentState!.validate() &&
  //       enteredPassword == Password &&
  //       enteredUsername == Username) {
  //     final admin = Hive.box('Admin');
  //     admin.put('isLoggedin', true);
  //   } else {
  //     print('not ok');
     
  //   }
  // }

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
  //   InputDecoration _inputDecoration(String labelText) {
  //   return InputDecoration(
  //     labelText: labelText,
  //     enabledBorder: const OutlineInputBorder(
  //       borderSide: BorderSide(color: Color.fromARGB(255, 104, 175, 107), width: 1),
  //       borderRadius: BorderRadius.all(Radius.circular(10)),
  //     ),
  //     border: const OutlineInputBorder(
  //       borderRadius: BorderRadius.all(Radius.circular(10)),
  //     ),
  //     contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
  //   );
  // }

}
