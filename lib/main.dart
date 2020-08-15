import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'home.dart';
import 'notifications.dart';
import 'profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        iconTheme: IconThemeData(color: Color(0xFF2C2C2C))),
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
    return new SplashScreen(
        seconds: 4,
        navigateAfterSeconds: new AfterSplash(),
        title: new Text(
          'CheapEats',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28.0,
              fontFamily: 'Comfort',
              color: Colors.orange),
        ),
        image: Image.asset('assets/loader-2.gif'),
        imageBackground: AssetImage('assets/Capture.png'),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 250.0,
        loaderColor: Colors.orange);
  }
}

class AfterSplash extends StatefulWidget {
  @override
  _AfterSplashState createState() => _AfterSplashState();
}

class _AfterSplashState extends State<AfterSplash> {
  PageController _pageController = PageController();
  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  var _currentIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[Home(), Notifications(), Profile()],
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: _onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        backgroundColor: Colors.black87,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 25,
              color: _currentIndex == 0 ? Colors.orange : Colors.white38,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                fontSize: 15,
                color: _currentIndex == 0 ? Colors.orange : Colors.white38,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.comments,
              color: _currentIndex == 1 ? Colors.orange : Colors.white38,
              size: 25,
            ),
            title: Text(
              'Feed',
              style: TextStyle(
                fontSize: 15,
                color: _currentIndex == 1 ? Colors.orange : Colors.white38,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 25,
              color: _currentIndex == 2 ? Colors.orange : Colors.white38,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: 15,
                color: _currentIndex == 2 ? Colors.orange : Colors.white38,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
