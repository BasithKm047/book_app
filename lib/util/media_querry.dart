import 'package:flutter/material.dart';

class ResponsiveHelper {
  final BuildContext context;
  ResponsiveHelper(this.context);

  double screenWidth() => MediaQuery.of(context).size.width;
  double screenHeight() => MediaQuery.of(context).size.height;

  double getResponsiveFontSize(double baseFontSize) {
    // This method helps scale font size based on screen width
    return screenWidth() / 100 * baseFontSize;
  }

  double getResponsiveHeight(double heightFactor) {
    // This method helps scale widgets' height
    return screenHeight() / 100 * heightFactor;
  }

  double getResponsiveWidth(double widthFactor) {
    // This method helps scale widgets' width
    return screenWidth() / 100 * widthFactor;
  }
}
