import 'package:flutter/material.dart';
import 'package:translate/view/mesaj_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translate My SMS',
      home: MessagePageScreen(),
    );
  }
}