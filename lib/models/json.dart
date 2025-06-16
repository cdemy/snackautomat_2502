import 'dart:convert';
import 'product.dart';

class ProductSerializer {
  /// Konvertiert ein Objekt zu einer JSON-Map.
  static Map<String, dynamic> toJson(Product product) {
    return {
      'name': product.name,
      'url': product.url,
      'price': product.price,
      'amount': product.amount,
    };
  }

  /// Erstellt ein Objekt aus einer JSON-Map.
  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      url: json['url'] as String,
      price: json['price'] as int,
      amount: json['amount'] as int,
    );
  }
}
