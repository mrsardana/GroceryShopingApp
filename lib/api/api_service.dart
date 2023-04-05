import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerry_shopping_app/main.dart';
import 'package:grocerry_shopping_app/models/category.dart';
import 'package:grocerry_shopping_app/config.dart';
import 'package:grocerry_shopping_app/models/fav.dart';
import 'package:grocerry_shopping_app/models/product.dart';
import 'package:grocerry_shopping_app/models/product_filter.dart';
import 'package:grocerry_shopping_app/models/slider.dart';
import 'package:grocerry_shopping_app/utils/shared_service.dart';
import 'package:http/http.dart' as http;

import '../models/cart.dart';
import '../models/login_response_model.dart';

final apiService = Provider((ref) => APIService());

class APIService {
  static var client = http.Client();
  Future<List<Category>?> getCategories(page, pageSize) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    Map<String, String> queryString = {
      'page': page.toString(),
      'pageSize': pageSize.toString()
    };
    var url = Uri.http(Config.apiURL, Config.categoryAPI, queryString);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return categoriesFromJson(data["data"]);
    } else {
      return null;
    }
  }

  Future<List<Product>?> getProducts(
      ProductFilterModel productFilterModel) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    Map<String, String> queryString = {
      'page': productFilterModel.paginationModel.page.toString(),
      'pageSize': productFilterModel.paginationModel.pageSize.toString()
    };

    if (productFilterModel.productName != null) {
      queryString["productName"] = productFilterModel.productName!;
    }
    if (productFilterModel.categoryId != null) {
      queryString["categoryId"] = productFilterModel.categoryId!;
    }

    if (productFilterModel.sortBy != null) {
      queryString["sort"] = productFilterModel.sortBy!;
    }

    var url = Uri.http(Config.apiURL, Config.productAPI, queryString);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return productsFromJson(data["data"]);
    } else {
      return null;
    }
  }

  static Future<bool> registerUser(
    String fullName,
    String email,
    String password,
    String address,
    String phone,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.registerAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {
          "fullName": fullName,
          "email": email,
          "password": password,
          "address": address,
          "phone": phone
        },
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> loginUser(
    String email,
    String password,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.loginAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {
          "email": email,
          "password": password,
        },
      ),
    );

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(
          loginResponseModelJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  Future<List<SliderModel>?> getSliders(page, pageSize) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    Map<String, String> queryString = {
      'page': page.toString(),
      'pageSize': pageSize.toString()
    };
    var url = Uri.http(Config.apiURL, Config.sliderAPI, queryString);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return slidersFromJson(data["data"]);
    } else {
      return null;
    }
  }

  Future<Product?> getProductDetails(String productId) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.productAPI + "/" + productId);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return Product.fromJson(data["data"]);
    } else {
      return null;
    }
  }

  Future<Cart?> getCart() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails?.data.token.toString()}'
    };

    var url = Uri.http(Config.apiURL, Config.cartAPI);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return Cart.fromJson(data['data']);
    } else if (response.statusCode == 401) {
      return null;
      // navigatorKey.currentState?.pushNamedAndRemoveUntil(
      //   "/lock",
      //   (route) => false,
      // );
    } else {
      return null;
    }
  }

  Future<bool?> addCartItem(productId, qty) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails?.data.token.toString()}'
    };

    var url = Uri.http(Config.apiURL, Config.cartAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "products": [
          {
            "product": productId,
            "qty": qty,
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      return null;
    } else {
      return null;
    }
  }

  Future<bool?> removeCartItem(productId, qty) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}'
    };

    var url = Uri.http(Config.apiURL, Config.cartAPI);
    var response = await client.delete(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {
          "productId": productId,
          "qty": qty,
        },
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
    } else {
      return null;
    }
  }

  Future<Fav?> getFav() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails?.data.token.toString()}'
    };

    var url = Uri.http(Config.apiURL, Config.favAPI);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return Fav.fromJson(data['data']);
    } else if (response.statusCode == 401) {
      return null;
    } else {
      return null;
    }
  }

  Future<bool?> addFavItem(productId) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails?.data.token.toString()}'
    };

    var url = Uri.http(Config.apiURL, Config.favAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "products": [
          {"product": productId}
        ]
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      return null;
    } else {
      return null;
    }
  }

  Future<bool?> removeFavItem(productId) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}'
    };

    var url = Uri.http(Config.apiURL, Config.favAPI);
    var response = await client.delete(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {"productId": productId},
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      return null;
    } else {
      return null;
    }
  }
}
