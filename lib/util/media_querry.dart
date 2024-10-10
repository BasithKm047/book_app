import 'package:flutter/material.dart';

class ResponsiveHelper {
  final BuildContext context;
  ResponsiveHelper(this.context);

  double screenWidth() => MediaQuery.of(context).size.width;
  double screenHeight() => MediaQuery.of(context).size.height;

  double getResponsiveFontSize(double baseFontSize) {
    return screenWidth() / 100 * baseFontSize;
  }

  double getResponsiveHeight(double heightFactor) {
    return screenHeight() / 100 * heightFactor;
  }

  double getResponsiveWidth(double widthFactor) {
    return screenWidth() / 100 * widthFactor;
  }
}
