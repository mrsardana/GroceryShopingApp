import 'package:flutter/material.dart';
import 'package:grocerry_shopping_app/widgets/widget_home_categories.dart';
import 'package:grocerry_shopping_app/widgets/widget_home_product.dart';
import 'package:grocerry_shopping_app/widgets/widget_home_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: const [
          HomeSliderWidget(),
          SizedBox(
            height: 8,
          ),
          HomeCategoriesWidget(),
          HomeProductsWidget(),
        ],
      ),
    );
  }
}
