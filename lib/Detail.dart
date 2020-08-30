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
  String selectedQuantity;
  String selectedItem;
  List<TableRow> rows = [
    TableRow(children: [
      Text(''),
      Text(
        'Item',
        style: TextStyle(fontSize: 17),
      ),
      Text(
        'Price',
        style: TextStyle(fontSize: 17),
      ),
      Text(
        'Quantity',
        style: TextStyle(fontSize: 17),
      )
    ])
  ];
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
    final Size size = MediaQuery.of(context).size;
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
                  backgroundColor: Colors.white,
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
                      child: Text(selected == null
                          ? '-'
                          : '\$${widget.card.prices[selected]}'),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Text(
                'Location: Location Will Go Here',
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
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
                        selectedItem = widget.card.items[value];
                      }),
                ),
                Flexible(
                  flex: 2,
                  child: TextField(
                    onChanged: (value) {
                      selectedQuantity = value;
                    },
                    decoration: InputDecoration(
                      hintText: selected != null
                          ? 'Max ${widget.card.quantities[selected]}'
                          : 'Select Item',
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
            SizedBox(height: 10),
            ButtonTheme(
              minWidth: 70,
              height: 25,
              buttonColor: Colors.orange,
              child: RaisedButton(
                onPressed: () {
                  bool noDuplicates = true;
                  setState(() {
                    for (TableRow row in rows) {
                      if (row.key == ValueKey(selectedItem)) {
                        row.children.removeAt(3);
                        row.children.add(Text(
                          selectedQuantity,
                          style: TextStyle(fontSize: 14),
                        ));
                        noDuplicates = false;
                      }
                    }
                    if (noDuplicates) {
                      rows.add(TableRow(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                int toRemove = 0;
                                for (int i = 0; i < rows.length; i++) {
                                  if (rows[i].key == ValueKey(selectedItem)) {
                                    toRemove = i;
                                  }
                                }
                                rows.removeAt(toRemove);
                              });
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            selectedItem,
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            '1.99',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            selectedQuantity,
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                        key: ValueKey(selectedItem),
                      ));
                    }
                  });
                },
                child: Text(
                  'Add Item',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Comfort',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: size.width * .8,
                  color: Colors.black26,
                  height: 100,
                  child: SingleChildScrollView(
                    child: Table(
                      columnWidths: {0: FractionColumnWidth(.11)},
                      children: rows,
                    ),
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: ButtonTheme(
                minWidth: 300,
                height: 40,
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
