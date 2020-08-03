import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class Feed1 {
  String restaurantName;
  String foodDiscount;
  String restaurantPickup;
  String restaurantPic;
  Feed1({String r, String f, String d, String p}) {
    restaurantName = r;
    foodDiscount = f;
    restaurantPickup = d;
    restaurantPic = p;
  }
}

List<Feed1> foodFeed = [
  Feed1(
      r: 'Taco Bell',
      f: 'is offering tacos for \$\4.99',
      d: 'Pickup at 7:30 pm',
      p: 'tacoBell.png'),
  Feed1(
      r: 'McDonalds',
      f: 'is offering McChickens for \$\0.99',
      d: 'Pickup at 2:30 pm',
      p: 'mcd.png'),
  Feed1(
      r: 'BWW',
      f: 'is offering wings for \$\1.99',
      d: 'Pickup at 6:00 pm',
      p: 'bww.png'),
  Feed1(
      r: 'Abishek B.',
      f: 'ordered burgers from Burger King',
      d: 'Picked up at 1:00 am',
      p: 'abishek_cheapeats.png'),
  Feed1(
      r: 'Sudeep R.',
      f: 'ordered pizzas from Pizza Hut',
      d: 'Picked up at 3:30 pm',
      p: 'sudeep_cheapeats.png')
];

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Friends & Favorites'))),
      body: SafeArea(
        child: Expanded(
          child: ListView.builder(
            itemCount: foodFeed.length,
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                onTap: null,
                title: Text(
                  foodFeed[index].restaurantName +
                      ' ' +
                      foodFeed[index].foodDiscount,
                  style: TextStyle(
                      fontFamily: 'Comfort',
                      fontSize: 20,
                      color: Colors.orange),
                ),
                subtitle: Text(
                  foodFeed[index].restaurantPickup,
                  style: TextStyle(
                      fontFamily: 'Comfort',
                      fontSize: 15,
                      color: Colors.white70),
                ),
                leading: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/${foodFeed[index].restaurantPic}'),
                  radius: 20.0,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                trailing: Column(
                  children: <Widget>[
                    Icon(
                      Icons.thumb_up,
                    ),
                    SizedBox(height: 5),
                    Icon(
                      Icons.comment,
                    )
                  ],
                ),
              ));
            },
          ),
        ),
      ),
    );
  }
}
