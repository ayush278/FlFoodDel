import '../helper/appData.dart';

class FoodModel {
  late int id;
  late String name;
  late String image;
  late String category;
  late int price;
  late String portion;
  late String calory;
  late String duration;
  FoodModel({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.price,
    this.portion = "1 portion",
    this.calory = "320 kcal",
    this.duration = "15 min",
  });
  FoodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = baseUrl + "foods/images/" + json['image'];
    category = json['category'];
    price = json['price'];
    portion = "1 portion";
    calory = "320 kcal";
    duration = "15 min";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['category'] = this.category;
    data['portion'] == "1 portion";
    data['calory'] == "320 kcal";
    data['duration'] == "15 min";

    return data;
  }
}
