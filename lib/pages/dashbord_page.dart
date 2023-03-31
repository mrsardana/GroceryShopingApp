import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocerry_shopping_app/pages/home_page.dart';
import 'package:grocerry_shopping_app/pages/my_account.dart';

import 'cart_page.dart';
import 'favotie_page.dart';

class DashboardPage extends StatefulWidget {
  int selectedPage;
  DashboardPage({super.key, required this.selectedPage});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Widget> widgetList = const [
    HomePage(),
    CartPage(),
    Favourite(),
    MyAccount(),
  ];

  int _index = 0;
  @override
  void initState() {
    super.initState();

    if (widget.selectedPage != null) {
      _index = widget.selectedPage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 23, 155, 69),
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
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
      body: widgetList[_index],
    );
  }
}
