import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocerry_shopping_app/pages/home_page.dart';

import 'cart_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Widget> widgetList = const [
    HomePage(),
    CartPage(),
    HomePage(),
    HomePage(),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 23, 155, 69),
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        onTap: (_index) {
          setState(() {
            index = _index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Store",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervisor_account_rounded),
            label: "My Account",
          ),
        ],
      ),
      body: widgetList[index],
    );
  }
}
