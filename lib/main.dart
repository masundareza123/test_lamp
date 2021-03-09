import 'package:flutter/material.dart';
import 'package:test_lamp/home_page.dart';
import 'package:test_lamp/login_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loginScreen(),
    );
  }
}
