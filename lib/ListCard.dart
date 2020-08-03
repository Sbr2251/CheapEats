import 'package:flutter/material.dart';

class ListCard {
  final String name;
  final String takeOutTime;
  final String image;
  final String cuisineType;
  final double distance;
  Color favorited;

  ListCard(this.name, this.takeOutTime, this.image, this.cuisineType,
      this.distance, this.favorited);
}
