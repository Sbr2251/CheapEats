class ListCard {
  final String name;
  final String takeOutTime;
  final String image;
  final String cuisineType;
  final double distance;
  final String logo;
  final List prices;
  final List items;
  final List quantities;
  bool favorited;

  ListCard(
      this.name,
      this.takeOutTime,
      this.image,
      this.cuisineType,
      this.distance,
      this.logo,
      this.prices,
      this.items,
      this.quantities,
      this.favorited);
}
