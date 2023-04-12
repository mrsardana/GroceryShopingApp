import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerry_shopping_app/providers.dart';
import 'package:grocerry_shopping_app/widgets/widget_orders.dart';

class OrderPage extends ConsumerStatefulWidget {
  const OrderPage({super.key});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage> {
  void initState() {
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   getOrderDetails();
  //   super.didChangeDependencies();
  // }

  // @override
  // Future<void> getOrderDetails() async {
  //   final orderDataProvider = ref.watch(orderProvider);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Page"),
      ),
      body: Container(
        // margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: orderList(ref),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget orderList(WidgetRef ref) {
    final orderDataProvider = ref.watch(orderProvider);

    if (orderDataProvider.orderModel == null) {
      return const LinearProgressIndicator();
    }
    if (orderDataProvider.orderModel?['data'].isEmpty) {
      return const Center(
        child: Text("No Order"),
      );
    }
    return _buildOrderItems(orderDataProvider.orderModel?['data'], ref);
  }

  Widget _buildOrderItems(orders, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return Orders(
          model: orders[index],
        );
      },
    );
  }
}
