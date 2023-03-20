import 'package:flutter/material.dart';
import 'package:grocerry_shopping_app/widgets/widget_home_categories.dart';
import 'package:grocerry_shopping_app/widgets/widget_home_product.dart';
import 'package:grocerry_shopping_app/widgets/widget_home_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Product model = ;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView(
        children: const [
          HomeSliderWidget(),
          SizedBox(
            height: 15,
          ),
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
