import 'dart:async';

import 'package:flutter/material.dart';
import 'package:check_points/check_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerry_shopping_app/api/api_service.dart';
import 'package:grocerry_shopping_app/config.dart';
import 'package:grocerry_shopping_app/providers.dart';
import 'package:grocerry_shopping_app/utils/shared_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class OrderDetailsPage extends ConsumerStatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends ConsumerState<OrderDetailsPage> {
  late List products;
  late String orderStatus;
  late String orderId;
  late String createdAt;
  late double grandTotal;
  late String transactionId;
  String? address;
  bool isLoading = false;
  @override
  void didChangeDependencies() {
    final Map? arguments = ModalRoute.of(context)!.settings.arguments as Map;

    if (arguments != null) {
      products = arguments["products"];
      orderStatus = arguments["orderStatus"];
      grandTotal = arguments["grandTotal"];
      orderId = arguments["id"];
      createdAt = arguments["createdAt"];
      transactionId = arguments["transactionId"];
    }
    getLoginDetails();
    super.didChangeDependencies();
  }

  @override
  Future<void> getLoginDetails() async {
    var loginDetails = await SharedService.loginDetails();
    address = loginDetails!.data.address.toString();
    setState(() {
      address = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : orderDetailUI(),
    );
  }

  Widget orderDetailUI() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Id: ***${orderId.substring(orderId.length - 5)}",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Order Date: ${createdAt.split("T")[0]}",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text("Delivered To"),
          Text(address != null ? address = address! : ""),
          const SizedBox(height: 20),
          const Text("Payment Method"),
          const Text("Visa"),
          const Divider(color: Colors.grey),
          const SizedBox(height: 5),
          orderStatus == "success"
              ? const CheckPoint(
                  checkedTill: 0,
                  checkPoints: ["Processing", "Delivered"],
                  checkPointFilledColor: Colors.green,
                )
              : orderStatus == "cancelled"
                  ? const Text(
                      "Order Cancelled",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text(
                      "Order Payment Failed",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          const Divider(color: Colors.grey),
          _listOrderItems(products),
          const Divider(color: Colors.grey),
          _itemTotal(
            "Total Amount",
            "${grandTotal.toStringAsFixed(2)}",
          ),
          _itemTotal(
            "Paid",
            "${grandTotal.toStringAsFixed(2)}",
          ),
          orderStatus == "success"
              ? Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text(
                            'Cancel Order',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const <Widget>[
                                Text(
                                    'Are you sure you want to cancel this order?'),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text(
                                'Yes',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                var response = await APIService().updateOrder(
                                  orderId,
                                  transactionId,
                                  "cancelled",
                                );
                                setState(() {
                                  isLoading = true;
                                });
                                Navigator.of(context).pop();
                                await Future.delayed(
                                    const Duration(seconds: 1));
                                if (response!) {
                                  setState(() {
                                    ref.invalidate(orderProvider);
                                    orderStatus = "cancelled";
                                    isLoading = false;
                                  });
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                            ),
                            TextButton(
                              child: const Text(
                                'No',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text("Cancel Order"),
                  ),
                )
              : Divider(color: Colors.grey[200]),
          Divider(color: Colors.grey[200]),
          Divider(color: Colors.grey[200]),
          Divider(color: Colors.grey[200]),
        ],
      ),
    );
  }

  Widget _listOrderItems(model) {
    return ListView.builder(
        itemCount: model.length,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _productItems(products[index]);
        });
  }

  Widget _productItems(Map<String, dynamic> product) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.all(2),
      onTap: null,
      title: Row(
        children: [
          SizedBox(
            child: Image.network(
              product['product']['productImage'],
              fit: BoxFit.cover,
            ),
            height: 50,
            width: 50,
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  product['product']['productName'],
                  // overflow: TextOverflow.ellipsis,
                  // style: TextStyle(fontSize: 7),
                ),
                Text(
                    'Price ${Config.currency}${product['product']['productSalePrice'].toString()}'),
                Text('Qty ${product['qty'].toString()}'),
              ],
            ),
          ),
        ],
      ),
      trailing:
          Text('${Config.currency}${product['amount'].toStringAsFixed(2)}'),
    );
  }

  Widget _itemTotal(
    String label,
    String value,
  ) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      contentPadding: const EdgeInsets.fromLTRB(2, -10, 2, -10),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Text(
        "${Config.currency}${value}",
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
