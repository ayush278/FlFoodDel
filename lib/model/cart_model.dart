class CartModel {
  late int id;
  late String name;
  late String image;
  late String category;
  late int price;
  late String portion;
  late String calory;
  late String duration;
  late int quantity;
  late String? orderId;
  CartModel(
      {required this.id,
      this.orderId,
      required this.name,
      required this.image,
      required this.category,
      required this.price,
      this.portion = "1 portion",
      this.calory = "320 kcal",
      this.duration = "15 min",
      this.quantity = 1});
  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    category = json['category'];
    price = json['price'];
    portion = "1 portion";
    calory = "320 kcal";
    duration = "15 min";
    if (json['quantity'] != null) {
      quantity = json['quantity'];
    } else {
      quantity = 1;
    }
    if (json['orderId'] != null) {
      orderId = json['orderId'].toString();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['category'] = this.category;
    data['portion'] = "1 portion";
    data['calory'] = "320 kcal";
    data['duration'] = "15 min";
    if (this.quantity != null) {
      data['quantity'] = this.quantity;
    } else {
      data['quantity'] = 1;
    }
    if (this.orderId != null) {
      data['orderId'] = this.orderId;
    } else {
      data['orderId'] = 1;
    }

    return data;
  }
}

Map<String, dynamic> toMapcartModel(CartModel cartModel) => {
      'id': cartModel.id,
      'name': cartModel.name,
      'image': cartModel.image,
      'price': cartModel.price,
      'category': cartModel.category,
      'portion': cartModel.portion,
      'calory': cartModel.calory,
      'duration': cartModel.duration,
      'quantity': cartModel.quantity ?? 1,
      'orderId': cartModel.orderId ?? 1,
    };
