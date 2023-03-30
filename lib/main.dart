import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerry_shopping_app/pages/dashbord_page.dart';
import 'package:grocerry_shopping_app/pages/get_started.dart';
import 'package:grocerry_shopping_app/pages/home_page.dart';
import 'package:grocerry_shopping_app/pages/login_page.dart';
import 'package:grocerry_shopping_app/pages/product_details_page.dart';
import 'package:grocerry_shopping_app/pages/products_page.dart';
import 'package:grocerry_shopping_app/pages/register_page.dart';
import 'package:grocerry_shopping_app/utils/shared_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Widget _defaultHome = const GetStarted();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _result = await SharedService.isLoggedIn();

  if (_result) {
    _defaultHome = const DashboardPage();
  }
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // primarySwatch: Color(0xff2980b9),
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.black,
              // statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromARGB(255, 23, 155, 69),
          ),
        ),
        // home: Scaffold(
        //   resizeToAvoidBottomInset: false,
        //   backgroundColor: Colors.grey[300],
        //   body: const GetStarted(),
        // ),
        navigatorKey: navigatorKey,
        routes: <String, WidgetBuilder>{
          '/': (context) => _defaultHome,
          '/regiseter': (BuildContext context) => const RegisterPage(),
          '/login': (BuildContext context) => const LoginPage(),
          '/products': (BuildContext context) => const ProductsPage(),
          '/home': (BuildContext context) => const DashboardPage(),
          '/product-details': (BuildContext context) =>
              const ProductDetailsPage(),
        });
  }
}
