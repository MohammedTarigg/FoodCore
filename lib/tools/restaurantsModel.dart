class RestaurantsModel {
  String name;
  String image;
  String description;
  String type;

  RestaurantsModel({
    required this.name,
    required this.image,
    required this.description,
    required this.type,
  });

  factory RestaurantsModel.fromMap(map) {
    return RestaurantsModel(
      name: map['name'],
      image: map['image'],
      description: map['description'],
      type: map['type'],
    );
  }
}
