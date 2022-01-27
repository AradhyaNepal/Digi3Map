
// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors


import 'package:digi3map/testing_all_navigation.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MainPage());
}

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Digi3Map",
      theme: ThemeData.light(),
      home: TestingAllNavigation(),
    );
  }
}
