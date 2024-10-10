import 'package:book_app/Admin/admin_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class AdminDetailsScreen extends StatelessWidget {
  final String ?name;
  final String ?image_path;
  const AdminDetailsScreen({super.key, this.name, this.image_path});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: // logout button
        Center(child: ElevatedButton(onPressed: (){
          _logoutAdmin(context);
    
        }, child:const Text('Logout') )),
    );
  }
  //   Future<bool> _handleBackButtonPress(BuildContext context) async {
  //   final adminBox = Hive.box('Admin');
  //   bool isLoggedIn = adminBox.get('isLoggedin', defaultValue: false);

  //   if (isLoggedIn) {
  //     // If the admin is logged in, close the app
  //     SystemNavigator.pop();  // This will close the app
  //     return false;  // Return false to prevent navigation
  //   } else {
  //     // Allow normal back button behavior if not logged in
  //     return true;  // Returning true will pop the route (go back)
  //   }
  // }
  void _logoutAdmin(BuildContext context) async{
  final adminBox = Hive.box('Admin');
  await adminBox.put('isLoggedin', false);  // Mark admin as logged out

  // Navigate back to the login screen
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => const AdminLoginScreen(),
  ));
}
}