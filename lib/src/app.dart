import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';

import './screens/checkout.dart';
import './screens/home.dart';
import './screens/get_product.dart';
import './models/product.dart';

class App extends StatefulWidget {
  createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  List<Product> products = [];

  AppState() {
    if (products.isEmpty) {
      fetchProducts();
    }
  }

  void fetchProducts() async {
    final url = Uri.parse('https://s3-eu-west-1.amazonaws.com/api.themeshplatform.com/products.json');
    final response = await get(url);

    final productModels = Product.listFromJson(json.decode(response.body)['data']);

    setState(() {
      products = productModels;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(
        products: products,
      ),
      onGenerateRoute: routes,
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name != null && settings.name!.length > 1) {
      if (settings.name!.contains('checkout')) {
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return  Checkout(
              products: products, 
            );
          },
        );
      }

      final id = int.parse(settings.name!.replaceFirst('/', ''));
      Product product = products[id];

      return MaterialPageRoute(
        builder: (BuildContext context) {
          return GetProduct(
            product: product,
            index: id,
          );
        },
      );
    }

    return MaterialPageRoute(
      builder: (BuildContext context) {
        return Home(products: products);
      },
    );
  }
}