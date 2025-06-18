import 'package:flutter/foundation.dart';
import 'package:snackauotmat_2502/state/cart_item.dart';

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
}

@immutable // Klasse kann nicht verändert werden
class AppState {
  final List<Snack> availableSnacks;
  final int currentCredit;
  final List<CartItem> cartItems;

  const AppState({
    this.availableSnacks = const [],
    this.currentCredit = 0,
    this.cartItems = const [],
  });

  AppState copyWith({
    List<Snack>? availableSnacks,
    int? currentCredit,
    List<CartItem>? cartItems,
  }) {
    return AppState(
      availableSnacks: availableSnacks ?? this.availableSnacks,
      currentCredit: currentCredit ?? this.currentCredit,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          listEquals(
            availableSnacks,
            other.availableSnacks,
          ) &&
          currentCredit == other.currentCredit &&
          listEquals(
            cartItems,
            other.cartItems,
          );

  @override
  int get hashCode =>
      availableSnacks.hashCode ^ currentCredit.hashCode ^ cartItems.hashCode;

  @override
  String toString() {
    return 'AppState{availableSnacks: $availableSnacks, currentCredit: $currentCredit, cartItems: $cartItems}';
  }
}
