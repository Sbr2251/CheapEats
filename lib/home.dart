import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'ListCard.dart';
import 'Detail.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  // final Geolocator geolocator = Geolocator();
  // var _location = "Location";
  bool displayingFiltered = false;
  @override
  bool get wantKeepAlive => true;
  static List<ListCard> cards;
  List<ListCard> filteredCards;

  @override
  void initState() {
    super.initState();
    cards = [
      ListCard('Swadeshi', '7:40', 'assets/swadeshi.jpeg', 'Indian', 1.6,
          Colors.grey),
      ListCard('Donut Palace', '8:40', 'assets/donut-shop.png', 'Desserts', 2.3,
          Colors.grey),
      ListCard('Kwality IceCream', '7:20', 'assets/ice-cream.jpg', 'Sundaes',
          4.8, Colors.grey),
    ];
    filteredCards = List.from(cards);
  }

  // void askLoc() async {
  //   Position position = await geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.best);
  //   print(position);
  //   setState(() {
  //     _location = position.toString();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    super.build(context);
    return new Scaffold(
        key: _scaffoldKey,
        endDrawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                  child: Center(
                      child: Text(
                'Filter By',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Comfort',
                  color: Colors.orange,
                ),
              ))),
              FlatButton(
                  color: displayingFiltered ? Colors.orange : Colors.grey,
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (!displayingFiltered) {
                      filteredCards.clear();
                      displayingFiltered = true;
                      setState(() {
                        for (int i = 0; i < cards.length; i++) {
                          if (cards[i].favorited == Colors.pink)
                            filteredCards.add(cards[i]);
                        }
                      });
                    } else {
                      displayingFiltered = false;
                      setState(() {
                        filteredCards = List.from(cards);
                      });
                    }
                  },
                  child: Text('Favorites',
                      style: TextStyle(
                        fontFamily: 'Comfort',
                      )))
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Restaurants'),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.filter_list),
                tooltip: 'Filter List',
                onPressed: () {
                  _scaffoldKey.currentState.openEndDrawer();
                })
          ],
          actionsIconTheme: IconThemeData(
            size: 35,
            color: Colors.white,
          ),
        ),
        body: ListView.builder(
            itemCount: filteredCards.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Detail(filteredCards[index])));
                  setState(() {
                    if (filteredCards[index].favorited == Colors.grey)
                      filteredCards[index].favorited = Colors.grey;
                    else
                      filteredCards[index].favorited = Colors.pink;
                  });
                },
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Hero(
                      child: Image.asset(filteredCards[index].image),
                      tag: '${filteredCards[index].name}',
                    ),
                    Container(
                      width: double.infinity,
                      height: 76,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      color: Color(0xDA2C2C2C),
                      child: Column(
                        children: <Widget>[
                          Text(
                            filteredCards[index].name,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            '${filteredCards[index].cuisineType} | Pickup ${filteredCards[index].takeOutTime} PM',
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
                          color: filteredCards[index].favorited,
                        ),
                        onTap: () {
                          setState(() {
                            if (filteredCards[index].favorited == Colors.grey)
                              filteredCards[index].favorited = Colors.pink;
                            else
                              filteredCards[index].favorited = Colors.grey;
                          });
                        },
                      ),
                      right: 10,
                      bottom: 25,
                    ),
                    Positioned(
                      child: Text(
                        '${filteredCards[index].distance} mi',
                        style: TextStyle(fontSize: 20),
                      ),
                      left: 5,
                      bottom: 30,
                    ),
                  ],
                ),
              );
              ;
            }));
  }
}
