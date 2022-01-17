import 'package:flutter/material.dart';

import './../models/product.dart';
import './../widgets/product_list.dart';

class Home extends StatelessWidget {
  List<Product> products = [];

  Home({required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ProductList(products),
        appBar: AppBar(
          title: const Text('Flutter Commerce'),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/checkout');
              }, 
              icon: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
    );
  }
}