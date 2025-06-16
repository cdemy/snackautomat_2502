/// Represents a single product in the machine.
class Product {
  /// The name of the product.
  final String name;

  /// The URL of the product image.
  final String url;

  /// The price of the product in Euro cents.
  final int price;

  /// The amount of this product in the machine.
  final int amount;

  /// Constructs a single product in the machine.
  Product({
    required this.name,
    required this.url,
    required this.price,
    required this.amount,
  });
}
