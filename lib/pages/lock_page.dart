import 'package:flutter/material.dart';

class LockedPage extends StatefulWidget {
  const LockedPage({super.key});

  @override
  State<LockedPage> createState() => _LockedPageState();
}

class _LockedPageState extends State<LockedPage> {
  void _loginPressed() {
    setState(() {
      Navigator.of(context).pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
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
              alignment: Alignment.center,
              height: 250,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Image.asset(
                'lib/assets/locked.png',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "You must sign-in to access this section",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(1),
              child: Container(
                padding: const EdgeInsets.all(0),
                width: 200,
                height: 52,
                child: ElevatedButton(
                  onPressed: _loginPressed,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Login',
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
