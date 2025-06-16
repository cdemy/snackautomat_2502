import 'package:flutter/foundation.dart';

@immutable
class Snack {
  final String id;
  final String name;
  final double price;
  final int quantity;

  const Snack({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  Snack copyWith({String? id, String? name, double? price, int? quantity}) {
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

@immutable // Macht die Klasse unveränderlich
class AppState {
  final List<Snack> availableSnacks;
  final double currentCredit; // Aktuell eingeworfenes Geld
  final String? selectedSnackId; // Das vom Nutzer ausgewählte Produkt

  const AppState({
    this.availableSnacks = const [],
    this.currentCredit = 0.0,
    this.selectedSnackId,
  });

  AppState copyWith({
    List<Snack>? availableSnacks,
    double? currentCredit,
    String? selectedSnackId,
  }) {
    return AppState(
      availableSnacks: availableSnacks ?? this.availableSnacks,
      currentCredit: currentCredit ?? this.currentCredit,
      selectedSnackId: selectedSnackId ?? this.selectedSnackId,
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
          selectedSnackId == other.selectedSnackId;

  @override
  int get hashCode =>
      availableSnacks.hashCode ^
      currentCredit.hashCode ^
      selectedSnackId.hashCode;

  @override
  String toString() {
    return 'AppState{availableSnacks: $availableSnacks, currentCredit: $currentCredit, selectedSnackId: $selectedSnackId}';
  }
}
