class Price {
  // price amount.
  String amount;

  // price currency.
  String currency;

  Price({
    required this.amount,
    required this.currency,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      amount: json['amount'], 
      currency: json['currency'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }

  @override
  String toString() => 'Price[amount=$amount, currency=$currency]';
}