import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';

import './models/product.dart';
import './widgets/product_list.dart';

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
      home: Scaffold(
        body: ProductList(products),
        appBar: AppBar(
          title: const Text('Flutter Commerce'),
        ),
      ),
    );
  }
}