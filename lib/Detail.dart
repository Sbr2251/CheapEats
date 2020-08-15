import 'package:flutter/material.dart';
import 'dart:math';
import 'ListCard.dart';

class Detail extends StatefulWidget {
  final ListCard card;
  Detail(this.card);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.card.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(alignment: Alignment.bottomCenter, children: <Widget>[
              Hero(
                tag: widget.card.name,
                child: Image.asset(
                  widget.card.image,
                ),
              ),
              Container(
                height: 40,
                color: Color(0xFF2C2C2C),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 30,
                  child: Divider(
                    color: Colors.orange,
                    thickness: 5,
                  )),
              Positioned(
                left: MediaQuery.of(context).size.width / 2 - 25,
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
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (widget.card.favorited == Colors.grey)
                        widget.card.favorited = Colors.pink;
                      else
                        widget.card.favorited = Colors.grey;
                    });
                  },
                  child: Icon(
                    Icons.favorite,
                    color: widget.card.favorited,
                    size: 30,
                  ),
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
                Column(
                  children: <Widget>[
                    Container(
                      child: Text('${Random().nextInt(10)}.99'),
                    ),
                    Container(
                      child: Text(
                        '80% off',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
                Text('|'),
                Column(
                  children: <Widget>[
                    Container(
                      child: Text('${widget.card.takeOutTime}'),
                    ),
                    Container(
                      child: Text(
                        'PM Pickup',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
                Text('|'),
                Column(
                  children: <Widget>[
                    Container(
                      child: Text('Veg'),
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
              'Location: Location Will Go Here',
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
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
