import './price.dart';

class Product {
  // product id.
  String id;

  // product sku.
  String sku;

  // product name.
  String name;

  // product brand name.
  String brandName; 

  // product main image.
  String mainImage;

  // product price.
  Price price;

  // product sizes.
  List<String> sizes = [];

  // product stock status.
  String stockStatus;

  // product colour.
  String colour;

  // product description.
  String description;

  Product({
    required this.id,
    required this.sku,
    required this.name,
    required this.brandName,
    required this.mainImage,
    required this.price,
    required this.sizes,
    required this.stockStatus,
    required this.colour,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final sizes = <String>[];
    for (var size in json['sizes']) {
      sizes.add(size.toString());
    }

    return Product(
      id: json['id'],
      sku: json['SKU'],
      name: json['name'],
      brandName: json['brandName'],
      mainImage: json['mainImage'],
      price: Price.fromJson(json['price']),
      sizes: sizes,
      stockStatus: json['stockStatus'],
      colour: json['colour'],
      description: json['description'],
    );
  }

  static List<Product> listFromJson(List<dynamic> json) {
    return json.map((dynamic value) => Product.fromJson(value)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sku': sku,
      'name': name,
      'brandName': brandName,
      'mainImage': mainImage,
      'price': price.toJson(),
      'sizes': sizes,
      'stockStatus': stockStatus,
      'colour': colour,
      'description': description,
    };
  }

  @override
  String toString() => 'Product[id=$id, sku=$sku, name=$name, brandName=$brandName, mainImage=$mainImage, price=$price, sizes=$sizes, stockStatus=$stockStatus, colour=$colour, description=$description]';
}