import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swadeshi'),
      ),
      body: Column(
        children: <Widget>[
          Stack(children: <Widget>[
            Hero(
              tag: 'detail',
              child: SafeArea(
                child: Image.asset('assets/swadeshi.jpeg'),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 100,
                top: 335,
                child: Divider(
                  color: Colors.orange,
                  thickness: 5,
                )),
            Positioned(
              right: 170,
              bottom: 0,
              child: CircleAvatar(
                backgroundColor: Colors.orange,
                radius: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(45),
                  child: CircleAvatar(
                    child: Image.asset('assets/swadeshi.png'),
                    radius: 35,
                  ),
                ),
              ),
            ),
            Positioned(
              child: Icon(
                Icons.favorite,
                color: Colors.grey,
                size: 30,
              ),
              bottom: 0,
              right: 20,
            )
          ]),
          SizedBox(height: 20),
          Row(
            // Details of restuarant
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconTheme(
                data: IconThemeData(color: Colors.orange, size: 40),
                child: Icon(Icons.monetization_on),
              ),
              Column(
                children: <Widget>[
                  Container(
                    child: Text('5.99'),
                  ),
                  Container(
                    child: Text(
                      '80% off',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
              IconTheme(
                data: IconThemeData(color: Colors.orange, size: 40),
                child: Icon(Icons.watch_later),
              ),
              Column(
                children: <Widget>[
                  Container(
                    child: Text('8:30'),
                  ),
                  Container(
                    child: Text(
                      'PM Pickup',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
              IconTheme(
                data: IconThemeData(color: Colors.orange, size: 40),
                child: Icon(Icons.restaurant),
              ),
              Column(
                children: <Widget>[
                  Container(
                    child: Text('Indian'),
                  ),
                  Container(
                    child: Text(
                      'Category',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 50),
          Text(
            'Choose: 2 Naan or 3 Samosa',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          Text(
            'Location: 7964 N MacArthur Blvd',
            style: TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: ButtonTheme(
              minWidth: 300,
              height: 50,
              child: RaisedButton(
                onPressed: () {},
                child: Text(
                  'Buy',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Comfort',
                      fontWeight: FontWeight.bold),
                ),
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }
}
