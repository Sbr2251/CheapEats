import 'package:flutter/material.dart';

class ListCard {
  final String name;
  final String takeOutTime;
  final String image;
  final String cuisineType;

  ListCard(this.name, this.takeOutTime, this.image, this.cuisineType);

  Stack getCard() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Hero(
          child: Image.asset(image),
          tag: 'detail',
        ),
        Container(
          width: double.infinity,
          height: 76,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          color: Color(0xDA2C2C2C),
          child: Column(
            children: <Widget>[
              Text(
                name,
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                '$cuisineType | Pickup $takeOutTime',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
