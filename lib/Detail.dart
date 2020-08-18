import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'ListCard.dart';

class Detail extends StatefulWidget {
  final ListCard card;
  final DocumentSnapshot snap;
  Detail(this.card, this.snap);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Color col;
  List<DropdownMenuItem<dynamic>> menuItems = [];
  int selected;
  @override
  void initState() {
    super.initState();
    col = widget.snap['favorited'] ? Colors.pink : Colors.grey;
    int count = 0;
    for (String s in widget.card.items) {
      menuItems.add(DropdownMenuItem(
        child: Text(s),
        value: count,
      ));
      count++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.card.name),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            await Firestore.instance.runTransaction((transaction) async {
              DocumentSnapshot freshSnap =
                  await transaction.get(widget.snap.reference);
              await transaction.update(freshSnap.reference,
                  {'favorited': col == Colors.grey ? false : true});
            });
            Navigator.of(context).pop();
          },
        ),
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
                left: MediaQuery.of(context).size.width / 2 - 40,
                bottom: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.orange,
                  backgroundImage: AssetImage(widget.card.logo),
                  radius: 40,
                ),
              ),
              Positioned(
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      col = col == Colors.pink
                          ? col = Colors.grey
                          : col = Colors.pink;
                    });
                  },
                  child: Icon(
                    Icons.favorite,
                    color: col,
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
                      child: Text('holder'),
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
                        widget.card.cuisineType,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 4,
                  child: DropdownButton(
                      items: menuItems,
                      value: selected,
                      hint: Text('Select Item'),
                      onChanged: (value) {
                        setState(() {
                          selected = value;
                        });
                      }),
                ),
                Flexible(
                  flex: 3,
                  child: TextField(
                    maxLength: 2,
                    decoration: InputDecoration(
                      hintText: 'Max 3',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                )
              ],
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
