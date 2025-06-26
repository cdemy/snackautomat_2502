import 'package:flutter/foundation.dart';

@immutable // Klasse kann nicht verändert werden
class Snack {
  final String id;
  final String name;
  final int price;
  final int quantity;

  const Snack({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

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

  //serializing
  factory Snack.fromJson(Map<String, dynamic> json) => Snack(
    id: json['id'] as String,
    name: json['name'] as String,
    price: json['price'] as int,
    quantity: json['quantity'] as int,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'quantity': quantity,
  };
}
