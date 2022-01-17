import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import './../models/product.dart';
import '../widgets/size_model.dart';

class GetProduct extends StatelessWidget {
  final Product product;
  final int index;

  GetProduct({required this.product, required this.index});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 5.0),
              child: Text(
                product.name, 
                textAlign: TextAlign.left, 
                style: const TextStyle(
                  fontWeight: FontWeight.bold, 
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  product.brandName,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF757575),
                  ),
                ),
              ),
            ),
            CachedNetworkImage(
              placeholder: (context, url) => const CircularProgressIndicator(),
              imageUrl: product.mainImage,
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${product.price.amount}${product.price.currency}",
                  style: const TextStyle(
                    fontSize: 15,
                     color: Colors.black,
                  ),
                ),
              ), 
            ),
            Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  product.stockStatus,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF757575),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'DESCRIPTION', 
                  textAlign: TextAlign.left, 
                  style: TextStyle(
                    fontSize: 14, 
                    color: Color(0xFF6F8398)
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0, left: 20.0, right: 20.0, bottom: 16.0),
              child: Text(
                product.description, 
                textAlign: TextAlign.justify, 
                style: const TextStyle(
                  height: 1.5, 
                  color: Color(0xFF6F8398)
                ),
              ),
            ),
            Container(
              height: 100,
            )
          ],
        )
      ),
      floatingActionButton: Stack(
        children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              width: MediaQuery.of(context).size.width,
              height: 55,
              child: FloatingActionButton.extended(
              onPressed: () {
                showModalBottomSheet(
                  context: context, 
                  builder: (BuildContext context){
                    return SizeModel(product, index);
                  }
                );
              },
              backgroundColor: Colors.green,
              label: const Text(
                'ADD TO BAG',
                style: TextStyle(fontSize: 18),
              ),
              shape: const RoundedRectangleBorder(),
            ),
          ),
        ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}