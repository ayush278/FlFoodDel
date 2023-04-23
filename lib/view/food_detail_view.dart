import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fooddel/helper/appData.dart';

import '../model/cart_model.dart';
import '../model/category_model.dart';
import '../model/food_model.dart';

class FoodDetailView extends StatefulWidget {
  final FoodModel seletedFoodModelData;
  const FoodDetailView({super.key, required this.seletedFoodModelData});

  @override
  State<FoodDetailView> createState() => _FoodDetailViewState();
}

class _FoodDetailViewState extends State<FoodDetailView> {
  int count = 1;
  List<CategoryModel> categoryExtrasList = [];

  @override
  void initState() {
    getMemoryInfo("FoodDetailView", "initState");

    if (categoryExtrasList.length == 0) {
      switch (whichCategorySelected) {
        case "Desserts":
          {
            categoryExtrasList = [
              CategoryModel(
                imagePath: "assets/caramel.png",
                imageName: "Caramel",
              ),
              CategoryModel(
                imagePath: "assets/whip_cream.png",
                imageName: "Cream",
              ),
              CategoryModel(
                imagePath: "assets/macadamia.png",
                imageName: "Hazelnut",
              ),
            ];
          }
          break;

        case "Drinks":
          {
            categoryExtrasList = [
              CategoryModel(
                imagePath: "assets/ice_cube.png",
                imageName: "Ice cubes",
              ),
              CategoryModel(
                imagePath: "assets/straw.png",
                imageName: "Straw",
              ),
            ];
          }
          break;

        default:
          {
            categoryExtrasList = [
              CategoryModel(
                imagePath: "assets/meal_mustard.png",
                imageName: "Sauces",
              ),
              CategoryModel(
                imagePath: "assets/meal_pickles.png",
                imageName: "Pickles",
              ),
              CategoryModel(
                imagePath: "assets/meal_spice.png",
                imageName: "Seasoning",
              ),
            ];
          }
          break;
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    getMemoryInfo("FoodDetailView", "dispose");

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xff5e3c37),
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: const Color(0xffebe8e2),
        body: Column(children: [
          Image.network(
            widget.seletedFoodModelData.image,
            height: MediaQuery.of(context).size.height * .40,
            width: MediaQuery.of(context).size.width * .70,
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
              child: Padding(
                padding: const EdgeInsets.only(top: 28, right: 28, left: 28),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.seletedFoodModelData.name,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                    icon: const Icon(
                                      Icons.remove,
                                      size: 35,
                                    ),
                                    onPressed: () {
                                      if (count != 1) {
                                        count = count - 1;
                                        setState(() {});
                                      }
                                    }),
                                Text(
                                  count.toString(),
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                IconButton(
                                    icon: const Icon(
                                      Icons.add,
                                      size: 35,
                                    ),
                                    onPressed: () {
                                      count = count + 1;
                                      setState(() {});
                                    }),
                              ]),
                          Text(
                            "\$${count * widget.seletedFoodModelData.price}",
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      Center(
                        child: SizedBox(
                          height: 145,
                          child: ListView.builder(
                            itemCount: categoryExtrasList.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  categoryExtrasList[index].isSelected =
                                      !categoryExtrasList[index].isSelected;

                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 100,
                                    color: categoryExtrasList[index].isSelected
                                        ? const Color(0xffebe8e2)
                                        : Colors.transparent,
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          categoryExtrasList[index].imagePath,
                                          height: 60,
                                          width: 60,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
                                          child: Text(
                                            categoryExtrasList[index].imageName,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // var rng = Random();
                          // int temp = rng.nextInt(999999);
                          CartModel cartModel = CartModel(
                            id: widget.seletedFoodModelData.id,
                            category: widget.seletedFoodModelData.category,
                            image: widget.seletedFoodModelData.image,
                            name: widget.seletedFoodModelData.name,
                            price: widget.seletedFoodModelData.price,
                            quantity: count,
                            // orderId:
                            //     "${widget.seletedFoodModelData.category} $temp"
                          );
                          cartDataListAppData.add(cartModel);
                          var snackBar = SnackBar(
                              content: Text(
                                  '$count ${widget.seletedFoodModelData.name} is added to the cart'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width * .80,
                          decoration: BoxDecoration(
                            color: Color(0xffdd713f),
                            borderRadius: BorderRadius.all(
                              Radius.circular(18.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Add to cart",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
