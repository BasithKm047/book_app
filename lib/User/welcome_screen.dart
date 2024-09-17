import 'package:book_app/User/login_screen.dart';
import 'package:book_app/User/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 104, 175, 107),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  // color: Colors.black,
                  )),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                      'Welcome to'),
                  // SizedBox(height: 5,),
                  Text(
                      style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                      'My Books')
                ],
              )),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70.0,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              // elevation: 0,

                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ));
                          },
                          child: Text(
                              style: GoogleFonts.roboto(
                                  color: const Color.fromARGB(255, 104, 175, 107)),
                              'Create Account')),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              backgroundColor:
                                  const Color.fromARGB(255, 104, 175, 107),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                            },
                            child: Text(
                                style: GoogleFonts.roboto(color: Colors.white),
                                'Log in'))),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
