import 'package:flutter/material.dart';
import 'package:check_points/check_points.dart';
import 'package:grocerry_shopping_app/config.dart';
import 'package:grocerry_shopping_app/utils/shared_service.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late List products;
  late String orderStatus;
  late String orderId;
  late String createdAt;
  late double grandTotal;
  String? address;
  @override
  void didChangeDependencies() {
    final Map? arguments = ModalRoute.of(context)!.settings.arguments as Map;

    if (arguments != null) {
      products = arguments["products"];
      orderStatus = arguments["orderStatus"];
      grandTotal = arguments["grandTotal"];
      orderId = arguments["id"];
      createdAt = arguments["createdAt"];
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
      body: orderDetailUI(),
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
