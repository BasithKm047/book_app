import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CostumSettingScreen extends StatefulWidget {
  const CostumSettingScreen({super.key});

  @override
  State<CostumSettingScreen> createState() => _CostumSettingScreenState();
}

class _CostumSettingScreenState extends State<CostumSettingScreen> {
  bool _isDarkmode=false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: AppBar(
      title: Text('Settings'
      ,style: CostumFontStyle(color: CostumColor().costum_color_1, fontSize: 15, fontWeight: FontWeight.w400).getFontstyle(),),
    ),
    body: Column(children: [
      ListTile(title: const Text('Dark mode'),
      trailing: Switch(value: _isDarkmode, onChanged: (value) {
        setState(() {
          _isDarkmode=value;
           
        });
        Provider.of(context)<ThemeProvider>(context,listen:false).toggleTheme(value);
      },),)
    ],),
    );

  }
}