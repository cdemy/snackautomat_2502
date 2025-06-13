/// Represents a single product in the machine.
class Product {
  final String name;
  final String url; // Internet url of image (including extension).
  final int price; // Price in Euro cents.
  final int amount;

  /// Constructs a single product in the machine.
  Product({
    required this.name,
    required this.url,
    required this.price,
    required this.amount,
  });
}
