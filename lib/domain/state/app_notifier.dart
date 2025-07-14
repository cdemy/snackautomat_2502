import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackautomat_2502/domain/state/app_state.dart';
import 'package:snackautomat_2502/models/coinstack.dart';
import 'package:snackautomat_2502/models/snack.dart';
import 'package:snackautomat_2502/services/persistence.dart';

/// Class AppNotifier handles the App State changes
class AppNotifier extends Notifier<AppState> {
  @override
  AppState build() {
    _loadInitialState();
    return const AppState(
      availableSnacks: [
        Snack(id: '1', name: 'Haribo', price: 120, quantity: 8),
        Snack(id: '2', name: 'Knoppers', price: 250, quantity: 5),
        Snack(id: '3', name: 'Erdnuss', price: 100, quantity: 8),
        Snack(id: '4', name: 'Milka', price: 200, quantity: 12),
        Snack(id: '5', name: 'Paprika chips', price: 100, quantity: 7),
        Snack(id: '6', name: 'Paulaner spezi', price: 230, quantity: 9),
        Snack(id: '7', name: 'Potato chips', price: 200, quantity: 4),
        Snack(
          id: '8',
          name: 'Sour cream onion chips',
          price: 250,
          quantity: 15,
        ),
        Snack(id: '9', name: 'Tuc cracker', price: 150, quantity: 6),
      ],
      machine: CoinStack.startCoins,
    );
  }

  Future<void> _loadInitialState() async {
    final loaded = await loadAppState();
    if (loaded != null) {
      state = loaded;
    }
  }

  Future<void> _persistState() async {
    await saveAppState(state);
  }

  /// Add coin to input and try to perform a transaction
  void addInput(int amount) {
    final newInput = state.input.addInt(amount);
    state = state.copyWith(input: () => newInput);
    _persistState();
    // doTransaction();
  }

  /// Clear the automate display
  void clearDisplayMessage() =>
      state = state.copyWith(displayMessage: () => null);

  /// Set a message on the automate display
  void setDisplayMessage(String message) {
    state = state.copyWith(displayMessage: () => message);
  }

  /// To perform a transaction, we first check if a snack is selected,
  /// available in the machine, and if enough coins are inserted.
  /// Then we check if change can be given. If not, we stop the process.
  /// If yes, we decrease the snack quantity by 1, give the change,
  /// clear the input, remove the selection, and finally update the state.

  void doTransaction() {
    clearDisplayMessage();
    if ((state.selectedSnack != null) &&
        (state.input.value >= state.selectedSnack!.price)) {
      final changeAmount = state.input.value - state.selectedSnack!.price;
      if (!state.machine.canGiveChange(changeAmount)) {
        setDisplayMessage("Can't give change!");
        return;
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
      const clearedInput = CoinStack(); // clear input
      final boughtSnack = state.selectedSnack;
      const Snack? clearedSelection = null; // remove selection of snack

      state = state.copyWith(
        availableSnacks: () => updatedSnackQuantity,
        machine: () => updatedMachine,
        output: () => updatedOutput,
        input: () => clearedInput,
        selectedSnack: () => clearedSelection,
      );
      setDisplayMessage('Success! Enjoy your ${boughtSnack!.name}!');
      if (state.selectedSnack != null &&
          state.input.value >= state.selectedSnack!.price) {
        _persistState();
      }
    }
  }

  /// Reset the vending machine to its default state
  void refillAutomate() {
    state = build();
    _persistState();
  }

  /// Return inserted coins and clear input
  void returnCredit() {
    state = state.copyWith(input: CoinStack.new);
    state = state.copyWith(output: CoinStack.new);
    _persistState();
  }

  /// If selected snack is available and different from current, select it;
  /// if it's the same — unselect. Then try transaction.

  void selectSnack(Snack snack) {
    if (snack != state.selectedSnack && snack.quantity > 0) {
      state = state.copyWith(selectedSnack: () => snack);
    } else {
      state = state.copyWith(selectedSnack: () => null);
    }
    _persistState();
    // doTransaction();
  }
}

/// Provide access to the AppNotifier, which manages all app state (snacks, coins, selection, etc.)
final appNotifierProvider = NotifierProvider<AppNotifier, AppState>(
  AppNotifier.new,
);
