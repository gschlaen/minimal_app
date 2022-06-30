import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromRGBO(7, 5, 5, 1);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primary,
  );
}
