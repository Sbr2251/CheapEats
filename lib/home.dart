import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'ListCard.dart';
import 'Detail.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  final Geolocator geolocator = Geolocator();
  var _location = "Location";
  var _color = Colors.grey;
  var cards = [
    ListCard('Swadeshi', '7:40 PM', 'assets/swadeshi.jpeg', 'Indian').getCard()
  ];

  @override
  bool get wantKeepAlive => true;

  void askLoc() async {
    Position position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    print(position);
    setState(() {
      _location = position.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
      appBar: AppBar(
        title: Text('Restaurants'),
        actions: <Widget>[
          Icon(Icons.filter_list),
        ],
        actionsIconTheme: IconThemeData(
          size: 35,
          color: Colors.white,
        ),
      ),
      body: ListView(
        children: <Widget>[
          GestureDetector(
            child: cards[0],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Detail()),
              );
            },
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Image.asset('assets/donut-shop.png'),
              Container(
                width: double.infinity,
                height: 76,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                color: Color(0xDA2C2C2C),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Donut Palace',
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Desserts | 12 Miles',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Image.asset('assets/ice-cream.jpg'),
              Positioned(
                child: Container(
                  child: Text(
                    '1.6 mi',
                    style: TextStyle(fontSize: 25),
                  ),
                  color: Color(0xDA2C2C2C),
                ),
                left: 0,
                top: 0,
              ),
              Container(
                width: double.infinity,
                height: 76,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                color: Color(0xDA2C2C2C),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Kwality IceCream',
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Sundaes | Pickup 7:30 PM',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Positioned(
                child: GestureDetector(
                  child: Icon(
                    Icons.favorite,
                    size: 35,
                    color: _color,
                  ),
                  onTap: () {
                    setState(() {
                      if (_color == Colors.pink)
                        _color = Colors.grey;
                      else
                        _color = Colors.pink;
                    });
                  },
                ),
                right: 10,
                bottom: 25,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
