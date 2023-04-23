import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fooddel/helper/appData.dart';
import 'package:fooddel/model/category_model.dart';
import 'package:fooddel/model/food_model.dart';
import 'package:fooddel/view/food_detail_view.dart';
import 'package:fooddel/view/order_view.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/allFood_data_model.dart';
import '../model/cart_model.dart';
import 'cart_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<FoodModel> foodsList = [];

  @override
  void initState() {
    getMemoryInfo("HomeView", "initState");

    super.initState();
  }

  @override
  void dispose() {
    getMemoryInfo("HomeView", "dispose");

    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<CategoryModel> categoryList = [
    CategoryModel(imagePath: "assets/menu.png", imageName: "All"),
    CategoryModel(imagePath: "assets/hamburger.png", imageName: "Meals"),
    CategoryModel(imagePath: "assets/cupcake.png", imageName: "Desserts"),
    CategoryModel(imagePath: "assets/hotdrinks.png", imageName: "Drinks"),
  ];
  Future<bool> getData() async {
    if (foodModelListAppData == null || foodModelListAppData.length == 0) {
      final url = Uri.parse(
        baseUrl + 'foods/getAllFoods.php',
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print(response.body);
        var jsonData = jsonDecode(response.body);

        AllFoodDataModel apiData = AllFoodDataModel.fromJson(jsonData);
        foodModelListAppData = apiData.foods!;
        foodsList = apiData.foods!;
        print("object");
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: const Color(0xffebe8e2),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.account_circle,
                color: Colors.grey[500],
                size: 35,
              ),
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: const Color(0xffebe8e2),
        drawerDragStartBehavior: DragStartBehavior.start,
        drawer: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 50,
          ),
          InkWell(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Cart",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () {
              if (cartDataListAppData.length != 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartView(),
                  ),
                );
              } else {
                var snackBar = SnackBar(content: Text('cart is empty'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
          ),
          InkWell(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Order History",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();

              final String? orderListString = prefs.getString('orderList');
              List<CartModel> OrderList;
              if (orderListString != null) {
                OrderList = decodeCartList(orderListString);
              } else {
                OrderList = [];
              }
              if (OrderList.length != 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderView(
                      orderList: OrderList,
                    ),
                  ),
                );
              } else {
                var snackBar =
                    SnackBar(content: Text('Order history is not present'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              //OrderView
            },
          ),
        ]),
        body: FutureBuilder<bool>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Food Delivery",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Text(
                            "104 Suraksha Enclave, pitampura, Delhi",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            prefixIcon: Icon(
                              Icons.search,
                              size: 30,
                              color: Colors.black.withOpacity(0.7),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.0),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                            hintText: "Search your fav. food",
                            fillColor: const Color(0xFFdddad6)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 120,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: categoryList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                categoryList.forEach((element) {
                                  whichCategorySelected =
                                      categoryList[index].imageName;
                                  if (element.imageName ==
                                      categoryList[index].imageName) {
                                    element.isSelected = true;
                                  } else {
                                    element.isSelected = false;
                                  }
                                });
                                foodsList = [];
                                foodModelListAppData.forEach((element) {
                                  if (whichCategorySelected != "All") {
                                    if (element.category ==
                                        whichCategorySelected) {
                                      foodsList.add(element);
                                    }
                                  } else {
                                    foodsList.add(element);
                                  }
                                });

                                setState(() {});
                              },
                              child: Container(
                                width: 100,
                                color: whichCategorySelected ==
                                        categoryList[index].imageName
                                    ? Colors.white
                                    : Colors.transparent,
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      categoryList[index].imagePath,
                                      height: 80,
                                      width: 80,
                                    ),
                                    Text(categoryList[index].imageName)
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.shade500,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: foodsList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                whichCategorySelected =
                                    foodsList[index].category;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FoodDetailView(
                                      seletedFoodModelData: foodsList[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    Image.network(
                                      foodsList[index].image,
                                      height: 80,
                                      width: 80,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 4),
                                      width: MediaQuery.of(context).size.width -
                                          (100 + 24),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "${foodsList[index].name}",
                                                style: const TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(),
                                              ),
                                              Text(
                                                "\$" +
                                                    "${foodsList[index].price}",
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                foodsList[index].portion,
                                                style: TextStyle(
                                                  color: Colors.grey[500],
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                foodsList[index].calory,
                                                style: TextStyle(
                                                  color: Colors.grey[500],
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(Icons.av_timer),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  foodsList[index].duration,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
