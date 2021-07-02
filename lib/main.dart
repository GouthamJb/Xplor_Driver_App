import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xplor_driver_app/views/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: HomeScreen());
  }
}
