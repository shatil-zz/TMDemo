import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  final ThemeData base = ThemeData(
      primarySwatch: Colors.blue,
      canvasColor: Colors.transparent,
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xff8468DD)));
  return base.copyWith(
    primaryColor: Colors.white,
    backgroundColor: const Color(0xff8468DD),
    canvasColor: Colors.transparent,
    dialogBackgroundColor: Colors.white,
    primaryIconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 24),
      headline5: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 24),
      bodyText2: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 18),
      bodyText1: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 16),
      caption: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.normal,
          color: Colors.black,
          fontSize: 14),
    ),
  );
}
