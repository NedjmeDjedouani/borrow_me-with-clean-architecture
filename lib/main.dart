import 'package:flutter/material.dart';
import 'package:test_app/login.dart';
import 'package:get/get.dart';

void main() {
  runApp(Myapp());

}

class Myapp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      theme:ThemeData(primaryColor: Colors.indigo[700],buttonColor: Colors.indigo[700],
          buttonTheme: ButtonThemeData(buttonColor:Colors.indigo[700] ),
          textTheme: TextTheme(button: TextStyle(color: Colors.white))),

    );
  }
}









