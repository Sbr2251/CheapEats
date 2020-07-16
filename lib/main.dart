import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'home.dart';

void main() {
  runApp(new MaterialApp(
    theme: ThemeData.dark().copyWith(
      backgroundColor: Color(0xFF2C2C2C),
      //primaryColor: Color(0xFF2C2C2C),
      textTheme: TextTheme(
        bodyText2: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
          color: Colors.orange,
          fontFamily: 'Comfort',
        ),
      ),
    ),
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Home();
    // return new SplashScreen(
    //     seconds: 4,
    //     navigateAfterSeconds: new AfterSplash(),
    //     title: new Text(
    //       'CheapEats',
    //       style: new TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 28.0,
    //           fontFamily: 'Comfort',
    //           color: Colors.orange),
    //     ),
    //     image: Image.asset('assets/loader-2.gif'),
    //     imageBackground: AssetImage('assets/Capture.png'),
    //     styleTextUnderTheLoader: new TextStyle(),
    //     photoSize: 300.0,
    //     loaderColor: Colors.orange);
  }
}
