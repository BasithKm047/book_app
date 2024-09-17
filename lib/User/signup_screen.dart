import 'package:book_app/User/home_screen.dart';
import 'package:book_app/User/login_screen.dart';
import 'package:book_app/User/navigator_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100.0),
        child: AppBar(
          toolbarHeight: 100.0,
          title: Text(style: GoogleFonts.merriweather(), 'Create Account'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 500,
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  shadowColor:
                      const Color.fromARGB(255, 104, 175, 107).withOpacity(1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Form(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 370,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30.0,
                              ),
                              SizedBox(
                                child: Image.asset(
                                    height: 170,
                                    width: 170,
                                    'Asset/book_image_1.jpeg'),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 104, 175, 107),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          labelText: 'User name',
                                          labelStyle: TextStyle(
                                            fontSize: 13.0,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 10.0,
                                            horizontal: 15.0,
                                          )),
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   height: 10.0,
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 104, 175, 107),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          labelText: 'Password',
                                          labelStyle: TextStyle(
                                            fontSize: 13.0,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 10.0,
                                            horizontal: 15.0,
                                          )),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 50.0,
                              width: double.infinity,
                              decoration: const BoxDecoration(),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const NavigatorScreen(),));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      shadowColor: Colors.black,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0))),
                                      backgroundColor: const Color.fromARGB(
                                          255, 104, 175, 107)),
                                  child: const Text(
                                      style: TextStyle(color: Colors.white),
                                      'Sign up'))),
                        ),
                        Text.rich(
                          TextSpan(
                              text: "Already have an account?",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11.0,
                              ),
                              children: [
                                TextSpan(
                                    text: 'Log in here',
                                    style: GoogleFonts.jacquesFrancois(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 104, 175, 107),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen(),
                                        ));
                                      })
                              ]),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
