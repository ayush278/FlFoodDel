import 'package:fooddel/model/food_model.dart';

class AllFoodDataModel {
  List<FoodModel>? foods;

  AllFoodDataModel({this.foods});

  AllFoodDataModel.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = <FoodModel>[];
      json['foods'].forEach((v) {
        foods!.add(FoodModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foods != null) {
      data['foods'] = this.foods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
