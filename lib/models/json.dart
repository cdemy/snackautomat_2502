//import 'dart:convert'; might be necessary
import 'product.dart';

class ProductSerializer {
  /// Konvertiert ein Objekt zu einer JSON-Map.
  static Map<String, dynamic> toJson(Product product) {
    return {
      'name': product.name,
      'url': product.url,
      'price': product.price, // Bleibt int
      'amount': product.amount,
    };
  }

  /// Erstellt ein Objekt aus einer JSON-Map.
  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      url: json['url'] as String,
      price: json['price'] as int, // Bleibt int
      amount: json['amount'] as int,
    );
  }
}
