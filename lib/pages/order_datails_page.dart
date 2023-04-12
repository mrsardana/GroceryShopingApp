import 'package:flutter/material.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late List products;
  late String orderStatus;
  late double grandTotal;
  @override
  void didChangeDependencies() {
    final Map? arguments = ModalRoute.of(context)!.settings.arguments as Map;

    if (arguments != null) {
      products = arguments["products"];
      orderStatus = arguments["orderStatus"];
      grandTotal = arguments["grandTotal"];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(products);
    return const Placeholder();
  }
}
