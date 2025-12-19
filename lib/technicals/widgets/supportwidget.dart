import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle boldTextFieledStyle() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle HeadlineTextFieledStyle() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle LightTextFieledStyle() {
    return const TextStyle(
      color: Colors.white70,
      fontSize: 15,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle smallBoldTextFieledStyle() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 13,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle smallSemiBoldTextFieledStyle() {
    return const TextStyle(
      color: Colors.white70,
      fontSize: 12,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
    );
  }
}
