import 'package:bpm/Screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
//    routes: <String, WidgetBuilder>{
//      '/phoneNumber': (BuildContext context) => new phoneNumber(),
//      '/register': (BuildContext context) => new register(),
//      '/FirstScreen': (BuildContext context) => new FirstScreen(4),
//      '/wallet': (BuildContext context) => new wallet(),
//      '/Reporting': (BuildContext context) => new Reporting(),
//    },
  ));
}