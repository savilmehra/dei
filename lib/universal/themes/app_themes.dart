import 'package:flutter/material.dart';
import 'package:config/Config.dart';
enum AppTheme { dark, light, custom }

enum LocalEnum { en, hi }

final appLocale = {
  LocalEnum.en: const Locale('en', 'US'),
  LocalEnum.hi: const Locale('hi', 'IN'),
};

final appThemeData = {
  AppTheme.dark: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.white,
      textTheme: testTheme),
  AppTheme.light: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.black,
      primarySwatch: Colors.teal,
      textTheme: testTheme),
  AppTheme.custom: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.greenAccent,
      primarySwatch: Colors.orange,
      textTheme: testTheme),
};
TextTheme testTheme = const TextTheme(
  headline1: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
  headline6: TextStyle(fontSize: 24.0, fontStyle: FontStyle.normal),
  bodyText2: TextStyle(fontSize: 12.0, fontStyle: FontStyle.normal),
);
