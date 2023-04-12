import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class OrderSuccess extends StatelessWidget {
  const OrderSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Success"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Your Order Has been placed!",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const Icon(
                Icons.celebration_rounded,
                size: 200,
                color: Colors.orange,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: FormHelper.submitButton(
                  "Go To Store!",
                  () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/home", (route) => false);
                  },
                  btnColor: const Color.fromARGB(255, 23, 155, 69),
                  borderColor: Colors.white,
                  txtColor: Colors.white,
                  borderRadius: 20,
                  width: 250,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
