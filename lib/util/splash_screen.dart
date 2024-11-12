import 'package:book_app/Admin/admin_navigator_screen.dart';
import 'package:book_app/User/navigator_screen.dart';
import 'package:book_app/util/services.dart';
import 'package:book_app/util/welcome_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
   checkLoggedInStatus();
  
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(


      backgroundColor:   CostumColor().costum_color_3,
      body: Center(
        child: Image.asset('Asset/kitaab-removebg-preview.png')),
    );
  }
   Future<void> checkLoggedInStatus() async {
    final admin = await Hive.openBox(adminServices);
    final user= await Hive.openBox(userServices);
    final isLoggedIn = admin.get('isLoggedin', defaultValue: false);
    final isUserLoggedin=user.get('isLoggedin',defaultValue: false);

    await Future.delayed(const Duration(seconds: 1));

    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => AdminNavigatorScreen(
          // image_path: _image?.path ?? '',
          // name: _adminNameController.text,
        ),
      ));
    }else if(isUserLoggedin){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NavigatorScreen(),));
    }
    else{
      
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const WelcomeScreen(),));
    }
  }

  //   Future<void> checkLoggedInStatusforUser() async {
  //   final admin = await Hive.openBox('user');
  //   final isLoggedIn = admin.get('isLoggedin', defaultValue: false);
  //   await Future.delayed(const Duration(seconds: 1));

  //   if (isLoggedIn) {
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
  //       builder: (context) => NavigatorScreen(
  //         // image_path: _image?.path ?? '',
  //         // name: _adminNameController.text,
  //       ),
  //     ));
  //   }else{
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const WelcomeScreen(),));
  //   }
  // }
}