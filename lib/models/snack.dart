// app_state.dart

import 'package:flutter/foundation.dart';

@immutable
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }

  factory Snack.fromJson(Map<String, dynamic> json) {
    return Snack(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
      quantity: json['quantity'] as int,
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
}
