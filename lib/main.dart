import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerry_shopping_app/pages/get_started.dart';
import 'package:grocerry_shopping_app/pages/home_page.dart';
import 'package:grocerry_shopping_app/pages/login_page.dart';
import 'package:grocerry_shopping_app/pages/products_page.dart';
import 'package:grocerry_shopping_app/pages/register_page.dart';
import 'package:grocerry_shopping_app/utils/shared_service.dart';

Widget _defaultHome = const GetStarted();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _result = await SharedService.isLoggedIn();

  if (_result) {
    _defaultHome = const HomePage();
  }
  runApp(const ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // primarySwatch: Color(0xff2980b9),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Color.fromARGB(255, 23, 155, 69),
          ),
        ),
        // home: Scaffold(
        //   resizeToAvoidBottomInset: false,
        //   backgroundColor: Colors.grey[300],
        //   body: const GetStarted(),
        // ),
        routes: <String, WidgetBuilder>{
          '/': (context) => _defaultHome,
          '/regiseter': (BuildContext context) => const RegisterPage(),
          '/login': (BuildContext context) => const LoginPage(),
          '/products': (BuildContext context) => const ProductsPage(),
          '/home': (BuildContext context) => const HomePage(),
        });
  }
}
