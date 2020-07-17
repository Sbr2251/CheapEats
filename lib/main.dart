import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'notifications.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

BottomNavigationBar bar = BottomNavigationBar(
  backgroundColor: Colors.black87,
  items: [
    BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.home,
        color: Colors.orange,
      ),
      title: Text(
        'Home',
        style: TextStyle(color: Colors.orange),
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.bell,
        color: Colors.orange,
      ),
      title: Text(
        'Feed',
        style: TextStyle(
          color: Colors.orange,
        ),
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.profile_circled,
        color: Colors.orange,
      ),
      title: Text(
        'Profile',
        style: TextStyle(color: Colors.orange),
      ),
    ),
  ],
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 10,
        navigateAfterSeconds: new Notifications(),
        title: new Text(
          'CheapEats',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              fontFamily: 'Comfort',
              color: Colors.orange),
        ),
        image: Image.asset('assets/loader-2.gif'),
        imageBackground: AssetImage('assets/Capture.png'),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 150.0,
        loaderColor: Colors.orange);
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.grey,
        body: new Center(
          child: new Text(
            "Done!",
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Colors.orange),
          ),
        ),
        bottomNavigationBar: bar);
  }
}
