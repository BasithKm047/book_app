import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CostumFontStyle {
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  CostumFontStyle({required this.color, required this.fontSize,required this.fontWeight,});
  TextStyle getFontstyle(){
    return GoogleFonts.lora(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
  TextStyle getFontstyle_2(){
    return GoogleFonts.roboto(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight
    );
  }
}