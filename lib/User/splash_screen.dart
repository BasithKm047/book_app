import 'package:book_app/User/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),() {
       // ignore: use_build_context_synchronously
       Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const HomeScreen(),));
    },);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(


      backgroundColor:  const Color.fromARGB(255, 123, 203, 127),
      body: Center(
        child: Image.asset('Asset/book_image_1.jpeg')),
    );
  }
}