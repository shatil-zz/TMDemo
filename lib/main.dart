import 'package:flutter/material.dart';
import 'package:tm_demo/screens/home/home_page.dart';
import 'package:tm_demo/utils/them_utils.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDemo',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const HomePage(),
    );
  }
}
