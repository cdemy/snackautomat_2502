class Product {
  final String name;
  final String url; // Internet url of image (including extension).
  final int price;
  final int amount;

  /// Constructs a single product in the machine.
  Product({
    required this.name,
    required this.url,
    required this.price,
    required this.amount,
  });

  /// Creates a Product from a JSON map
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      url: json['url'] as String,
      price: json['price'] as int,
      amount: json['amount'] as int,
    );
  }

  /// Converts the Product to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'price': price,
      'amount': amount,
    };
  }

  @override
  String toString() {
    return 'Product(name: $name, url: $url, price: $price, amount: $amount)';
  }
}
