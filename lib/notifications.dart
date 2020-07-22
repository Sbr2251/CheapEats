import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class Feed1{
  String restaurantName;
  String foodDiscount;
  String restaurantDistance;
  String restaurantPic;
  Feed1({String r, String f, String d, String p}) {
    restaurantName = r;
    foodDiscount = f;
    restaurantDistance = d;
    restaurantPic = p;
  }

}
List<Feed1> foodFeed = [
  Feed1(r: 'Taco Bell', f: 'Tacos 20% off', d: '1.6 miles away', p: 'tacoBell.png'),
  Feed1(r: 'McDonalds', f: 'McChicken 40% off', d: '2.4 miles away', p: 'mcd.png'),
  Feed1(r: 'BWW', f: 'Wings 10% off', d: '1.3 miles away', p: 'bww.png'),
];

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:Expanded(
          child: ListView.builder(
            itemCount: foodFeed.length,
            itemBuilder: (context, index){
              return Card(
                child: ListTile(
                  onTap: null,
                  title: Text(foodFeed[index].restaurantName),
                  leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/${foodFeed[index].restaurantPic}'),
                      radius: 30.0,
                  ),
                  trailing: Text(foodFeed[index].restaurantDistance),
                  contentPadding: EdgeInsets.symmetric(horizontal:16.0),
                )
              );
            },
          ),
          ),
      ),
      bottomNavigationBar: bar,
    );
  }
}


