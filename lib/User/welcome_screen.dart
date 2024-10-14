
import 'package:book_app/Admin/admin_navigator_screen.dart';
import 'package:book_app/User/login_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    checkLoggedInStatus();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CostumColor().costum_color_4,
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
                      style: CostumFontStyle(color: CostumColor().costum_color, fontSize: 13, fontWeight: FontWeight.w300).getFontstyle(),
                      'Welcome to'),
                  // SizedBox(height: 5,),
                  Text(
                      style: CostumFontStyle(color: CostumColor().costum_color, fontSize: 20, fontWeight: FontWeight.w400).getFontstyle(),
                      'My Books')
                ],
              )),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 70.0,
                  //   width: double.infinity,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: ElevatedButton(
                  //         style: ElevatedButton.styleFrom(
                  //             backgroundColor: Colors.white,
                  //             // elevation: 0,

                  //             shape: const RoundedRectangleBorder(
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(10)))),
                  //         onPressed: () {
                          
                  //         },
                  //         child: Text(
                  //             style: GoogleFonts.roboto(
                  //                 color: const Color.fromARGB(255, 104, 175, 107)),
                  //             'Create Account')),
                  //   ),
                  // ),
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
                                style: CostumFontStyle(color: CostumColor().costum_color_1, fontSize: 15, fontWeight: FontWeight.w400).getFontstyle(),
                                'Get start'))),
                  )
                ],
              )),
        ],
      ),
    );
  }
    Future<void> checkLoggedInStatus() async {
    final admin = await Hive.openBox('Admin');
    final isLoggedIn = admin.get('isLoggedin', defaultValue: false);

    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => AdminNavigatorScreen(
          // image_path: _image?.path ?? '',
          // name: _adminNameController.text,
        ),
      ));
    }
  }

}
