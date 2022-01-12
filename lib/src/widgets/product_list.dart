import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/product.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;

  ProductList(this.products);

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return buildProduct(context, products[index], index);
      },
    );
  }

  Widget buildProduct(BuildContext context, Product product, int index) {
    return Card(
      elevation: 4.0,
      child: Column(
        children: [
          Container(
            height: 200.0,
            child: CachedNetworkImage(
              placeholder: (context, url) => const CircularProgressIndicator(),
              imageUrl: product.mainImage,
            ),
          ),
          ListTile(
            title: Text(product.name),
            subtitle: Text(product.stockStatus),
            trailing: const Icon(Icons.favorite_outline),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Text(product.price.amount + product.price.currency),
          ),
          ButtonBar(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/$index');
                }, 
                child: const Text('View'),
              )
            ],
          ),
        ],
      ),
    );
  }
}