import 'package:flutter/material.dart';
import 'package:grocerry_shopping_app/config.dart';

class Orders extends StatefulWidget {
  const Orders({
    super.key,
    required this.model,
  });
  final model;
  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    // print(widget.model['userId']);
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            _orderStatus("${widget.model['orderStatus']}"),
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconText(
                  const Icon(Icons.edit, color: Colors.green),
                  const Text(
                    "Order ID",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "***${widget.model['_id'].substring(widget.model['_id'].length - 5)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconText(
                  const Icon(Icons.today, color: Colors.green),
                  const Text(
                    "Order Date",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "${widget.model['createdAt'].split("T")[0]}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconText(
                  const Icon(Icons.currency_exchange_rounded,
                      color: Colors.green),
                  const Text(
                    "Order Total",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "${Config.currency}${widget.model['grandTotal'].toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                flatBotton(
                  Row(
                    children: const [
                      Text("Order Details"),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget iconText(Icon iconWidget, Text textWidget) {
    return Row(
      children: [
        iconWidget,
        const SizedBox(
          width: 5,
        ),
        textWidget
      ],
    );
  }

  Widget flatBotton(Widget iconText) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(
          "/order-details",
          arguments: {
            'products': widget.model['products'],
            'grandTotal': widget.model['grandTotal'],
            'orderStatus': widget.model['orderStatus'],
          },
        );
      },
      child: iconText,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget _orderStatus(String status) {
    Icon icon;
    Color color;

    if (status == "pending" || status == "processing") {
      icon = const Icon(Icons.clear, color: Colors.redAccent);
      color = Colors.redAccent;
      status = "Failed";
    } else if (status == "success") {
      icon = const Icon(Icons.check, color: Colors.green);
      color = Colors.green;
    } else if (status == "cancelled") {
      icon = const Icon(Icons.clear, color: Colors.red);
      color = Colors.red;
    } else {
      icon = const Icon(Icons.clear, color: Colors.red);
      color = Colors.red;
    }

    return iconText(
      icon,
      Text(
        "Order $status",
        style: TextStyle(
          fontSize: 15,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
