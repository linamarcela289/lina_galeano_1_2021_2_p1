
import 'package:appdogs/screens/breed_detail_screen.dart';
import 'package:appdogs/screens/breed_screens.dart';
import 'package:appdogs/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      home:  HomeScreens (),
    );
  }
}