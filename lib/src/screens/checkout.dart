import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import './../models/checkout_item.dart';
import './../models/product.dart';
import './../blocs/item_bloc.dart';

class Checkout extends StatelessWidget {
  Checkout({required this.products});

  List<Product> products;

  final ItemBloc itemBloc = ItemBloc();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: getCheckoutWidget(),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              width: MediaQuery.of(context).size.width,
              height: 55,
              child: FloatingActionButton.extended(
              onPressed: () => {},
              backgroundColor: Colors.green,
              label: const Text(
                'BUY NOW',
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

  Widget getCheckoutWidget() {
    return StreamBuilder(
      stream: itemBloc.items,
      builder: (BuildContext context, AsyncSnapshot<List<CheckoutItem>> snapshot) {
        return getItemsWidget(snapshot);
      },
    );
  }

  Widget getItemsWidget(AsyncSnapshot<List<CheckoutItem>> snapshot) {
    if (snapshot.hasData) {
      List<Widget> items = [
        Container(
            padding: const EdgeInsets.all(16.0),
            child: const Center(
              child: Text(
                'Checkout',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ),
          ),
      ];
      if (snapshot.data != null && snapshot.data!.isNotEmpty) {
        for (var item in snapshot.data!) {
          items.add(Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: ListTile(
              leading: CachedNetworkImage(
                placeholder: (context, url) => const CircularProgressIndicator(),
                imageUrl: products[item.productId].mainImage,
              ),
              title: Text(products[item.productId].name),
              subtitle: Text('Quantity: ' + item.quantity.toString() + ', Size: ' + item.size.toString()),
              trailing: IconButton(
                onPressed: () {
                  // @TODO: add delete functionality.
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          ));
        }
      }

      return Column(
        children: items,
      );
    }

    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                "No items", 
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      )
    );
  }
}