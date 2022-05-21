class RestaurantsModel {
  String name;
  String image;
  String description;

  RestaurantsModel({
    required this.name,
    required this.image,
    required this.description,
  });

  factory RestaurantsModel.fromMap(map) {
    return RestaurantsModel(
      name: map['name'],
      image: map['image'],
      description: map['description'],
    );
  }
}
