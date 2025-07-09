import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackautomat_2502/models/snack.dart';
import 'package:snackautomat_2502/models/coinstack.dart';
import 'package:snackautomat_2502/domain/state/app_state.dart';
import 'package:snackautomat_2502/services/persistence.dart'; // hinzufügen
import 'package:snackautomat_2502/services/database_simulator.dart';

class AppNotifier extends Notifier<AppState> {
  @override
  AppState build() {
    _loadInitialState();
    return const AppState(
      availableSnacks: [],
      input: CoinStack(),
      output: CoinStack(),
      machine: CoinStack.startCoins,
    );
  }

  // Future<void> _loadInitialState() async {
  //   print("Loading initial state...");
  //   final loaded = await DatabaseSimulator.getInitialAppState();
  //   print("Initial state loaded: $loaded");
  //   state = loaded;
  // }

  Future<void> _loadInitialState() async {
    print("Loading initial state...");
    final loaded = DatabaseSimulator.getInitialAppState().then(
      (value) => {
        state = value,
        print("Initial state loading FINISHED: $value"),
      },
    );
    print("Initial state loading RUNS: $loaded");
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
      final clearedInput = const CoinStack(); // clear input
      final boughtSnack = state.selectedSnack;
      final clearedSelection = null; // remove selection of snack

      state = state.copyWith(
        availableSnacks: () => updatedSnackQuantity,
        machine: () => updatedMachine,
        output: () => updatedOutput,
        input: () => clearedInput,
        selectedSnack: () => clearedSelection,
      );
      setDisplayMessage("Success! Enjoy your ${boughtSnack!.name}!");
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
    state = state.copyWith(input: () => CoinStack());
    state = state.copyWith(output: () => CoinStack());
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
