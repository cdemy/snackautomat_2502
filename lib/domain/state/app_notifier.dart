import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackautomat_2502/models/snack.dart';
import 'package:snackautomat_2502/domain/state/app_state.dart';
import 'package:snackautomat_2502/models/coinstack.dart';

class AppNotifier extends Notifier<AppState> {
  @override
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
    machine: CoinStack.startCoins,
  );

  /// Add coin to input and try to perform a transaction
  void addInput(int amount) {
    final newInput = state.input.addInt(amount);
    state = state.copyWith(input: () => newInput);
    doTransaction();
  }

  /// To perform a transaction, we first check if a snack is selected,
  /// available in the machine, and if enough coins are inserted.
  /// Then we check if change can be given. If not, we stop the process.
  /// If yes, we decrease the snack quantity by 1, give the change,
  /// clear the input, remove the selection, and finally update the state.

  void doTransaction() {
    if ((state.selectedSnack != null) &&
        (state.input.value >= state.selectedSnack!.price)) {
      final changeAmount = state.input.value - state.selectedSnack!.price;
      if (!state.machine.canGiveChange(changeAmount)) {
        return; //TODO: implement situation with no available change
      }
      final updatedSnackQuantity = state.availableSnacks.map((snack) {
        if (snack.id == state.selectedSnack!.id) {
          return Snack(
            id: snack.id,
            name: snack.name,
            price: snack.price,
            quantity: snack.quantity - 1,
          );
        } else {
          return snack;
        }
      }).toList(); // decrease snack quantity by 1
      final updatedMachine = state.machine.merge(
        state.input,
      ); // add coins to machine
      final changeCoins = updatedMachine.giveChange(
        changeAmount,
      ); // calculate change
      final updatedOutput = state.output.merge(changeCoins!); // give change
      final clearedInput = const CoinStack(); // clear input
      final clearedSelection = null; // remove selection of snack

      state = state.copyWith(
        availableSnacks: () => updatedSnackQuantity,
        machine: () => updatedMachine,
        output: () => updatedOutput,
        input: () => clearedInput,
        selectedSnack: () => clearedSelection,
      );
    } //TODO: implement "no snack or not enough money" message
  }

  /// Reset the vending machine to its default state
  void refillAutomate() {
    state = build();
  }

  /// Return inserted coins and clear input
  void returnCredit() {
    state = state.copyWith(input: () => CoinStack());
  }

  /// If selected snack is available and different from current, select it;
  /// if it's the same — unselect. Then try transaction.

  void chooseSnack(Snack snack) {
    if (snack != state.selectedSnack && snack.quantity > 0) {
      state = state.copyWith(selectedSnack: () => snack);
    } else {
      state = state.copyWith(selectedSnack: () => null);
    }
    doTransaction();
  }
}

/// Provide access to the AppNotifier, which manages all app state (snacks, coins, selection, etc.)
final appNotifierProvider = NotifierProvider<AppNotifier, AppState>(
  AppNotifier.new,
);
