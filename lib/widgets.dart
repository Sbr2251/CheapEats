import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Bar extends StatelessWidget {
  const Bar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
            'Notifications',
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
  }
}
