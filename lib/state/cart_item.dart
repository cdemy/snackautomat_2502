import 'package:flutter/foundation.dart';
import 'package:snackauotmat_2502/state/app_state.dart';

@immutable
class CartItem {
  final Snack snack; // Das Snack-Objekt, das im Warenkorb liegt
  final int quantity; // Die Menge dieses Snacks, die der Nutzer kaufen möchte

  const CartItem({
    required this.snack,
    required this.quantity,
  });

  CartItem copyWith({
    Snack? snack,
    int? quantity,
  }) {
    return CartItem(
      snack: snack ?? this.snack,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          snack == other.snack &&
          quantity == other.quantity;

  @override
  int get hashCode => snack.hashCode ^ quantity.hashCode;

  @override
  String toString() {
    return 'CartItem{snack: ${snack.name}, quantity: $quantity}';
  }
}
