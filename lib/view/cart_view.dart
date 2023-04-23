import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fooddel/helper/appData.dart';
import 'package:fooddel/model/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    getMemoryInfo("CartView", "initState");

    super.initState();
  }

  @override
  void dispose() {
    getMemoryInfo("CartView", "dispose");

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
          title: Text(
            "My Cart",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xffebe8e2),
        body: Column(mainAxisSize: MainAxisSize.min, children: [
          ListView.builder(
            itemCount: cartDataListAppData.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Image.network(
                        cartDataListAppData[index].image,
                        height: 80,
                        width: 80,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 4),
                        width: MediaQuery.of(context).size.width - (100 + 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${cartDataListAppData[index].name}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "Order Amount: ${cartDataListAppData[index].quantity}",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "Price: \$${cartDataListAppData[index].price} x ${cartDataListAppData[index].quantity} = \$${cartDataListAppData[index].price * cartDataListAppData[index].quantity}",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "Category: ${cartDataListAppData[index].category}",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 14,
                                ),
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
        ]),
        floatingActionButton: InkWell(
          onTap: () async {
            Navigator.of(context).pop();
            var rng = Random();
            int temp = rng.nextInt(999999);

            String orderId = DateTime.now().millisecondsSinceEpoch.toString();

            final SharedPreferences prefs =
                await SharedPreferences.getInstance();

            final String? orderListString = await prefs.getString('orderList');
            List<CartModel> OrderList;
            if (orderListString != null) {
              OrderList = decodeCartList(orderListString);
            } else {
              OrderList = [];
            }
            cartDataListAppData.forEach((element) {
              element.orderId = orderId;
              OrderList.add(element);
            });
            final String encodedData = encodeCartList(OrderList);

            await prefs.setString('orderList', encodedData);
            cartDataListAppData = [];
            dev.log("OrderList length:" + OrderList.length.toString());
            var snackBar = SnackBar(content: Text('Payment done'));
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
                "Pay",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
