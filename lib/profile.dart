import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register.dart';
import 'login.dart';

class Achievements {
  String restaurantName;
  String goal1;
  String goal2;
  String goal3;
  String progressMade;
  double percentage;
  Achievements(
      {String r, String g1, String g2, String g3, String p, double n}) {
    restaurantName = r;
    goal1 = g1;
    goal2 = g2;
    goal3 = g3;
    progressMade = p;
    percentage = n;
  }
}

double textSize = 17;

List<Achievements> targetList = [
  Achievements(
      r: 'CheapEats',
      g1: 'Invite 5 friends',
      g2: 'Interact with feed',
      g3: 'Make 5 purchases',
      p: '3',
      n: 0.6),
  Achievements(
      r: 'Dairy Queen',
      g1: 'Go to website',
      g2: 'Like posts on feed',
      g3: 'Make 5 purchases',
      p: '4',
      n: 0.8),
  Achievements(
      r: 'Subway',
      g1: 'Go to website',
      g2: 'Like posts on feed',
      g3: 'Make 5 purchases',
      p: '1',
      n: 0.2),
];

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  String firstName;
  String lastName;
  bool _isLoggedIn = false;
  String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.settings),
                tooltip: 'Settings',
                onPressed: () {})
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: CircleAvatar(
                  radius: 30,
                  backgroundImage: _isLoggedIn
                      ? NetworkImage(url)
                      : AssetImage('assets/dummy.jpeg')),
            ),
            Text(_isLoggedIn ? firstName : 'Not Logged In',
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(flex: 1, child: Container()),
                Expanded(
                  flex: 6,
                  child: Column(
                    children: <Widget>[
                      Text('\$\132',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30)),
                      Text(
                        'Savings',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 6,
                  child: Column(children: <Widget>[
                    Text('55',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30)),
                    Text(
                      'Friends',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ]),
                ),
                Spacer(),
                Expanded(
                  flex: 6,
                  child: Column(
                    children: <Widget>[
                      Text('17',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30)),
                      Text(
                        'Favorites',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Expanded(flex: 1, child: Container()),
              ],
            ),
            Container(height: 40),
            SizedBox(
                width: 350,
                child: Text('Achievements:',
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25))),
            Container(height: 3),
            SizedBox(
                width: 350,
                child: Text(
                  'Earn free access to CheapEats Premium for 2 weeks!',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                )),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                // ignore: missing_return
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                        onTap: null,
                        title: Row(
                          children: <Widget>[
                            Text(targetList[index].restaurantName,
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: textSize - 2)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                      targetList[index].goal1 +
                                          '  (' +
                                          targetList[index].progressMade +
                                          '/5)',
                                      style: TextStyle(
                                          fontSize: textSize,
                                          color: Colors.orange)),
                                  Text(
                                      targetList[index].goal2 +
                                          '  (' +
                                          targetList[index].progressMade +
                                          '/5)',
                                      style: TextStyle(
                                          fontSize: textSize,
                                          color: Colors.orange)),
                                  Text(
                                      targetList[index].goal3 +
                                          '  (' +
                                          targetList[index].progressMade +
                                          '/5)',
                                      style: TextStyle(
                                          fontSize: textSize,
                                          color: Colors.orange))
                                ],
                              ),
                            )
                          ],
                        ),
                        leading: CircularPercentIndicator(
                          radius: 50.0,
                          lineWidth: 5.0,
                          percent: 1 - targetList[index].percentage,
                          center: Text(
                            (targetList[index].percentage * 100)
                                    .toInt()
                                    .toString() +
                                '%',
                            style: TextStyle(fontSize: 15),
                          ),
                          progressColor: Colors.grey.shade700,
                          backgroundColor: Colors.blue,
                        )),
                  );
                },
              ),
            ),
            RaisedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Register()),
                );
                FirebaseUser user = await _auth.currentUser();
                setState(() {
                  firstName = user.displayName.split(" ")[0];
                  lastName = user.displayName.split(" ")[1];
                });
              },
              child: Text('Register'),
            ),
            RaisedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
                FirebaseUser user = await _auth.currentUser();
                setState(() {
                  firstName = user.displayName.split(" ")[0];
                  lastName = user.displayName.split(" ")[1];
                  url = user.photoUrl;
                  _isLoggedIn = true;
                });
              },
              child: Text('Login'),
            )
          ],
        ));
  }
}
