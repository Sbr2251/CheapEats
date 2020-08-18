import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'ListCard.dart';
import 'Detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                    // Navigator.of(context).pop();
                    // if (!displayingFiltered) {
                    //   filteredCards.clear();
                    //   displayingFiltered = true;
                    //   setState(() {
                    //     for (int i = 0; i < cards.length; i++) {
                    //       if (cards[i].favorited == Colors.pink)
                    //         filteredCards.add(cards[i]);
                    //     }
                    //   });
                    // } else {
                    //   displayingFiltered = false;
                    //   setState(() {
                    //     filteredCards = List.from(cards);
                    //   });
                    // }
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
        body: StreamBuilder(
          stream: Firestore.instance.collection('Restaurants').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot snap = snapshot.data.documents[index];
                  return GestureDetector(
                    onTap: () async {
                      ListCard lc = ListCard(
                          snap['name'],
                          snap['pickup'],
                          'assets/' + snap['picture'],
                          snap['cuisine'],
                          5,
                          'assets/' + snap['logo'],
                          snap['price'],
                          snap['items'],
                          snap['quantity'],
                          snap['favorited']);
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Detail(lc, snap)));
                    },
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1580 / 960,
                          child: Hero(
                            tag: snap['name'],
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                alignment: FractionalOffset.topCenter,
                                image: AssetImage('assets/' + snap['picture']),
                              )),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 76,
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          color: Color(0xDA2C2C2C),
                          child: Column(
                            children: <Widget>[
                              Text(
                                snap['name'],
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '${snap['cuisine']} | Pickup ${snap['pickup']} PM',
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
                              color:
                                  snap['favorited'] ? Colors.pink : Colors.grey,
                            ),
                            onTap: () async {
                              Firestore.instance
                                  .runTransaction((transaction) async {
                                DocumentSnapshot freshSnap =
                                    await transaction.get(snap.reference);
                                await transaction.update(freshSnap.reference, {
                                  'favorited': snap['favorited'] ? false : true
                                });
                              });
                            },
                          ),
                          right: 10,
                          bottom: 25,
                        ),
                        Positioned(
                          child: Text(
                            '5 mi',
                            style: TextStyle(fontSize: 20),
                          ),
                          left: 5,
                          bottom: 30,
                        ),
                      ],
                    ),
                  );
                });
          },
        ));
  }
}
