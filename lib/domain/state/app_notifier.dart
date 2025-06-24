import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackautomat_2502/models/snack.dart';
import 'package:snackautomat_2502/domain/state/app_state.dart';
import 'package:snackautomat_2502/models/coinstack.dart';

class AppNotifier extends Notifier<AppState> {
  AppState build() => const AppState(
    availableSnacks: [
      Snack(id: '1', name: 'Kuchen', price: 250, quantity: 8),
      Snack(id: '2', name: 'Chips', price: 120, quantity: 5),
      Snack(id: '3', name: 'Cola', price: 200, quantity: 8),
      Snack(id: '4', name: 'Wasser', price: 100, quantity: 12),
      Snack(id: '5', name: 'Gummibärchen', price: 180, quantity: 7),
      Snack(id: '6', name: 'Apfelsaft', price: 170, quantity: 9),
      Snack(id: '7', name: 'Sandwich', price: 350, quantity: 4),
      Snack(id: '8', name: 'Müsliriegel', price: 130, quantity: 15),
      Snack(id: '9', name: 'Eistee', price: 220, quantity: 6),
    ],
    input: CoinStack(),
    output: CoinStack(),
    machine: CoinStack.random,
  );

  void addInput(int amount) {
    final newInput = state.input.addInt(amount);
    state = state.copyWith(input: () => newInput);
    doTransaction();
  }

  void doTransaction() {}

  void resetVendingMachine() {
    state = build();
  }

  void returnCredit() {
    state = state.copyWith(input: () => CoinStack());
  }

  void chooseSnack(Snack snack) {
    if (snack != state.selectedSnack && snack.quantity > 0) {
      state = state.copyWith(selectedSnack: () => snack);
    } else {
      state = state.copyWith(selectedSnack: () => null);
    }
    doTransaction();
  }
}

final appNotifierProvider = NotifierProvider<AppNotifier, AppState>(
  AppNotifier.new,
);
