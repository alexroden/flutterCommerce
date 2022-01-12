import 'package:flutter/material.dart';
import 'package:http/http.dart';

import './../../utils/media_query_units.dart';

import './../models/product.dart';

class SizeModel extends StatefulWidget {
  const SizeModel(
    this.product,
  );

  final Product product;

  @override
  _SizeModelState createState() => _SizeModelState();
}

class _SizeModelState extends State<SizeModel> {
  bool status = false;
  int selectedSize = 0;
  bool isLoading = false;

  disableButton() {
    setState(() {
      status = false;
    });
  }
  
  enableButton() {
    setState(() {
      status = true;
    });
  }

  setSize(String value) {
    setState(() {
      selectedSize = int.parse(value);
    });
  }

  startLoad() {
    setState(() {
      isLoading = true;
    });
  }

  stopLoad() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, double> mediaQuery = getMediaQuery(context);

    final EdgeInsets _padding = EdgeInsets.symmetric(
      vertical: mediaQuery['height']! * 0.2,
      horizontal: mediaQuery['width']!,
    );

    final List<Widget> sizeSelectorWidgets = widget.product.sizes.map((String size) {
      return Container(
        // padding: _padding,
        margin: const EdgeInsets.only(left: 1.0, right: 1.0, bottom: 3.0),
        decoration: BoxDecoration(
          color: size == selectedSize.toString() ? Colors.grey.shade200 : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ButtonTheme(
          minWidth: mediaQuery['width']! * 12.5,
          child: TextButton(
            style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              return Colors.transparent;
            }),
          ),
            child: Text(size),
            onPressed: () {
              setSize(size);
              enableButton();
            }, 
          ),
        ),
      );
    }).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: mediaQuery['width']! * 5.0),
                    child: const Text('SELECT A SIZE'),
                  )
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuery['width']! * 5.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                    widget.product.sizes.isNotEmpty
                    ? Wrap(
                      direction: Axis.horizontal,
                      children: sizeSelectorWidgets,
                    )
                    : const Center(
                      child: Text(
                        'No sizes available',
                      ),
                    ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10.0),
            child: ElevatedButton(
              onPressed: status ? () async {
                startLoad();
                await Future.delayed(const Duration(seconds: 3));
                stopLoad();
                Navigator.pop(context);
                const snackBar = SnackBar(
                  content: Text('Product added to basket'),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } : null, 
              child: isLoading ? const SizedBox(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
                height: 10,
                width: 10,
              ) : const Text('ADD TO BAG'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
                primary: Colors.green,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 22.0)
          ),
      ],
    );
  }
}