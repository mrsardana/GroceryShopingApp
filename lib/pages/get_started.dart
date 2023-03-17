import 'package:flutter/material.dart';
import 'package:grocerry_shopping_app/pages/register_page.dart';

import 'home_page.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  void _getStartedPressed() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RegisterPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 120,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Image.asset(
                'lib/assets/il_getStarted.png',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Shop Your Daily",
              style: TextStyle(
                fontSize: 32,
                color: Color.fromARGB(255, 23, 155, 69),
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Necessary",
              style: TextStyle(
                fontSize: 32,
                color: Color.fromARGB(255, 23, 155, 69),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(1),
              child: Container(
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 23, 155, 69),
                  borderRadius: BorderRadius.circular(30),
                ),
                width: 280,
                height: 52,
                child: ElevatedButton(
                  onPressed: _getStartedPressed,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                        color: Color.fromARGB(255, 231, 225, 225),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
