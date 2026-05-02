import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 650;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 650 &&
        MediaQuery.of(context).size.width < 1100;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1100;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Responsive padding
  static EdgeInsets pagePadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 24);
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 32, vertical: 32);
    } else {
      return const EdgeInsets.symmetric(horizontal: 64, vertical: 48);
    }
  }

  // Responsive grid columns
  static int gridColumns(BuildContext context) {
    if (isMobile(context)) {
      return 1;
    } else if (isTablet(context)) {
      return 2;
    } else {
      return 3;
    }
  }

  // Max content width for desktop
  static double maxContentWidth(BuildContext context) {
    if (isDesktop(context)) {
      return 1200;
    }
    return double.infinity;
  }
}
