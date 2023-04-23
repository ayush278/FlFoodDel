library fooddel.globals;

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:fooddel/model/food_model.dart';
import 'package:memory_info/memory_info.dart';

import '../model/cart_model.dart';

List<FoodModel> foodModelListAppData = [];
String whichCategorySelected = "All";
String baseUrl = "";
List<CartModel> cartDataListAppData = [];
String encodeCartList(List<CartModel> cart) => json.encode(
      cart.map<Map<String, dynamic>>((cart) => toMapcartModel(cart)).toList(),
    );

List<CartModel> decodeCartList(String cart) => (json.decode(cart))
    .map<CartModel>((item) => CartModel.fromJson(item))
    .toList();

Future<void> getMemoryInfo(String pageName, String session) async {
  Memory? memory;
  DiskSpace? diskSpace;
  // Platform messages may fail, so we use a try/catch PlatformException.
  // We also handle the message potentially returning null.
  try {
    memory = await MemoryInfoPlugin().memoryInfo;
    memory.appMem;
    diskSpace = await MemoryInfoPlugin().diskSpace;
    log("Memory Log on $pageName $session  ${DateTime.now()} app memory:${memory.appMem} free memory:${memory.freeMem} free diskSpace:${diskSpace.freeSpace}");
  } on PlatformException catch (e) {
    print('error $e');
  }
}
