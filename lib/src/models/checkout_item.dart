class CheckoutItem {
  // checkout item id,
  late int id;

  // checkout item product id,
  int productId;

  // checkout item quantity,
  int quantity;

  // checkout item size,
  int size;

  CheckoutItem({
    this.id = 0,
    required this.productId,
    required this.quantity,
    required this.size,
  });

  factory CheckoutItem.fromDatabaseJson(Map<String, dynamic> data) => CheckoutItem(
    id: data['id'],
    productId: data['productId'],
    quantity: data['quantity'],
    size: data['size'],
  );

  Map<String, dynamic> toDatabaseJson() => {
    "productId": productId,
    "quantity": quantity,
    "size": size,
  };

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'quantity': quantity,
      'size': size,
    };
  }

  @override
  String toString() => 'CheckoutItem[id=$id, productId=$productId, quantity=$quantity, size=$size]';
}