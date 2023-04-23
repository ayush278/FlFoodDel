import 'package:flutter/material.dart';

import '../helper/appData.dart';
import '../model/cart_model.dart';

class OrderView extends StatefulWidget {
  final List<CartModel> orderList;
  const OrderView({super.key, required this.orderList});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  void initState() {
    getMemoryInfo("OrderView", "initState");

    super.initState();
  }

  @override
  void dispose() {
    getMemoryInfo("OrderView", "dispose");

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
            "Order",
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
            itemCount: widget.orderList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Image.network(
                        widget.orderList[index].image,
                        height: 100,
                        width: 100,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 8),
                        width: MediaQuery.of(context).size.width - (100 + 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${widget.orderList[index].name}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "Order Amount: ${widget.orderList[index].quantity}",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "Price: \$${widget.orderList[index].price} x ${widget.orderList[index].quantity} = \$${widget.orderList[index].price * widget.orderList[index].quantity}",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "Category: ${widget.orderList[index].category}",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "Order ID: ${widget.orderList[index].orderId}",
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
      ),
    );
  }
}
