import 'package:flutter/material.dart';

enum AppThemes { lightTheme, darkTheme }

final appThemeData = {
  AppThemes.lightTheme:
      ThemeData(brightness: Brightness.light, primaryColor: Colors.white),
  AppThemes.darkTheme:
      ThemeData(brightness: Brightness.dark, primaryColor: Colors.black87),
};
