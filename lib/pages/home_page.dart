import 'package:flutter/material.dart';
import 'package:grocerry_shopping_app/widgets/widget_home_categories.dart';
import 'package:grocerry_shopping_app/widgets/widget_home_product.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Product model = ;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView(
        children: const [
          HomeCategoriesWidget(),
          HomeProductsWidget(),
          // ProductCard(
          //   model: model,
          // ),
        ],
      ),
    );
  }
}
