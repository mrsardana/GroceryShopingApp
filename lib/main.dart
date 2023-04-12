import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:grocerry_shopping_app/pages/dashbord_page.dart';
import 'package:grocerry_shopping_app/pages/get_started.dart';
import 'package:grocerry_shopping_app/pages/home_page.dart';
import 'package:grocerry_shopping_app/pages/lock_page.dart';
import 'package:grocerry_shopping_app/pages/login_page.dart';
import 'package:grocerry_shopping_app/pages/my_details_page.dart';
import 'package:grocerry_shopping_app/pages/order_datails_page.dart';
import 'package:grocerry_shopping_app/pages/order_page.dart';
import 'package:grocerry_shopping_app/pages/order_success.dart';
import 'package:grocerry_shopping_app/pages/payment_page.dart';
import 'package:grocerry_shopping_app/pages/product_details_page.dart';
import 'package:grocerry_shopping_app/pages/products_page.dart';
import 'package:grocerry_shopping_app/pages/register_page.dart';
import 'package:grocerry_shopping_app/utils/shared_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Widget _defaultHome = const GetStarted();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _result = await SharedService.isLoggedIn();

  // if (_result) {
  //   _defaultHome =  DashboardPage();
  // }

  Stripe.publishableKey =
      "pk_test_51Mu0OoHXCuiZd6y5xt7WoDmTOjrFn7qKRdzDGLOJNHQvnISdAcnpQlCg8dorkq909yuvOgaGTb7ZP6mV3SVenU7800Ux5l2pZj";
  await Stripe.instance.applySettings();
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
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.grey[300],
          body: const GetStarted(),
        ),
        navigatorKey: navigatorKey,
        routes: <String, WidgetBuilder>{
          // '/': (context) => _defaultHome,
          '/regiseter': (BuildContext context) => const RegisterPage(),
          '/login': (BuildContext context) => const LoginPage(),
          '/lock': (BuildContext context) => const LockedPage(),
          '/products': (BuildContext context) => const ProductsPage(),
          '/getStarted': (BuildContext context) => const GetStarted(),
          '/home': (BuildContext context) => DashboardPage(selectedPage: 0),
          '/payments': (context) => const PaymentPage(),
          '/order-success': (context) => const OrderSuccess(),
          '/product-details': (BuildContext context) =>
              const ProductDetailsPage(),
          '/my-details': (BuildContext context) => MyDetails(),
          '/order': (BuildContext context) => const OrderPage(),
          '/order-details': (BuildContext context) => const OrderDetailsPage(),
        });
  }
}
