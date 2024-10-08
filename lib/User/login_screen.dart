
import 'package:book_app/Admin/admin_login_screen.dart';
import 'package:book_app/User/user_screen.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isAdmin = false;
  bool isUser=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CostumColor().costum_color_4,
      appBar: AppBar(
        backgroundColor: CostumColor().costum_color_4,
        centerTitle: true,
        // toolbarHeight: 100.0,
        title: Text(
            style: CostumFontStyle(
                    color: CostumColor().costum_color,
                    fontSize: 20,
                    fontWeight: FontWeight.w400)
                .getFontstyle(),
            'Log in'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              isAdmin ? const AdminLoginScreen() : const UserScreen(),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: ResponsiveHelper(context).getResponsiveHeight(7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: CostumColor().costum_color),
                    color: CostumColor().costum_color_3),
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        isAdmin = !isAdmin;
                   
                        
                      });
                    },
                    child: Text(
                        style: CostumFontStyle(
                                color: CostumColor().costum_color,
                                fontSize: 15,
                                fontWeight: FontWeight.w400)
                            .getFontstyle(),
                        isAdmin? 'Log in as User':'Log in as Admin'))
              ),
            ],
          ),
        ),
      ),
    );
  }
}
