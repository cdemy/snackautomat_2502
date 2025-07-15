import 'package:flutter/foundation.dart';

/// Class Snack with attributes, that immutable is
@immutable
class Snack {
  /// ID number of the Snack
  final String id;

  /// Name of the Snack
  final String name;

  /// Price of the Snack
  final int price;

  /// Quantity of the Snack
  final int quantity;

  /// Regular constructor
  const Snack({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  /// Returns new Snack object from old Snack object with some attribute changes
  Snack copyWith({String? id, String? name, int? price, int? quantity}) {
    return Snack(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Snack &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          price == other.price &&
          quantity == other.quantity;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ price.hashCode ^ quantity.hashCode;

  @override
  String toString() {
    return 'Snack{id: $id, name: $name, price: $price, quantity: $quantity}';
  }

  /// Create Snack object from JSON map (Serializing)
  factory Snack.fromJson(Map<String, dynamic> json) => Snack(
    id: json['id'] as String,
    name: json['name'] as String,
    price: json['price'] as int,
    quantity: json['quantity'] as int,
  );

  /// Create JSON from Snack object
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'quantity': quantity,
  };
}
