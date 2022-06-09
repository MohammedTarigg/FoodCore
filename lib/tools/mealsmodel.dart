class MealsModel {
  String name;
  int price;
  String image;

  MealsModel({required this.name, required this.price, required this.image});

  factory MealsModel.fromMap(map) {
    return MealsModel(
      name: map['name'],
      price: map['price'],
      image: map['image'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'image': image,
    };
  }
}
