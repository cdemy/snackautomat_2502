import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackauotmat_2502/state/app_state.dart';

class AppNotifier extends StateNotifier<AppState> {
  AppNotifier()
    : super(
        const AppState(
          availableSnacks: [
            Snack(id: '1', name: 'Schokolade', price: 1.50, quantity: 10),
            Snack(id: '2', name: 'Chips', price: 1.20, quantity: 5),
            Snack(id: '3', name: 'Cola', price: 2.00, quantity: 8),
          ],
        ),
      );

  void addCredit(double amount) {
    if (amount <= 0) return;
    state = state.copyWith(currentCredit: state.currentCredit + amount);
    print(
      'Guthaben hinzugefügt: $amount. Neues Guthaben: ${state.currentCredit}',
    );
  }

  void selectSnack(String snackId) {
    final snack = state.availableSnacks.firstWhere(
      (s) => s.id == snackId,
      orElse: () => throw Exception('Snack not found'),
    );

    if (snack.quantity == 0) {
      print('Snack "${snack.name}" ist ausverkauft.');
      state = state.copyWith(selectedSnackId: null);
      return;
    }

    if (state.currentCredit < snack.price) {
      print(
        'Nicht genug Guthaben für "${snack.name}". Benötigt: ${snack.price}, Aktuell: ${state.currentCredit}',
      );
      state = state.copyWith(
        selectedSnackId: snackId,
      );
      return;
    }

    state = state.copyWith(selectedSnackId: snackId);
    print('Snack "${snack.name}" ausgewählt.');
  }

  void purchaseSelectedSnack() {
    if (state.selectedSnackId == null) {
      print('Kein Snack ausgewählt.');
      return;
    }

    final snackToPurchase = state.availableSnacks.firstWhere(
      (s) => s.id == state.selectedSnackId,
      orElse: () => throw Exception('Ausgewählter Snack nicht gefunden.'),
    );

    if (snackToPurchase.quantity == 0) {
      print('Snack "${snackToPurchase.name}" ist ausverkauft.');
      state = state.copyWith(selectedSnackId: null);
      return;
    }

    if (state.currentCredit < snackToPurchase.price) {
      print(
        'Nicht genug Guthaben für "${snackToPurchase.name}". Benötigt: ${snackToPurchase.price}, Aktuell: ${state.currentCredit}',
      );
      return;
    }

    final updatedSnacks = state.availableSnacks.map((snack) {
      if (snack.id == snackToPurchase.id) {
        return snack.copyWith(quantity: snack.quantity - 1);
      }
      return snack;
    }).toList();

    final newCredit = state.currentCredit - snackToPurchase.price;

    state = state.copyWith(
      availableSnacks: updatedSnacks,
      currentCredit: newCredit,
      selectedSnackId: null,
    );

    print(
      '"${snackToPurchase.name}" Restguthaben: ${state.currentCredit}',
    );
  }

  void clearSelection() {
    if (state.selectedSnackId != null) {
      state = state.copyWith(selectedSnackId: null);
      print('Auswahl zurückgesetzt.');
    }
  }

  void resetVendingMachine() {
    state = const AppState(
      availableSnacks: [
        Snack(id: '1', name: 'Schokolade', price: 1.50, quantity: 10),
        Snack(id: '2', name: 'Chips', price: 1.20, quantity: 5),
        Snack(id: '3', name: 'Cola', price: 2.00, quantity: 8),
      ],
    );
    print('Snackautomat zurückgesetzt.');
  }
}

final appNotifierProvider = StateNotifierProvider<AppNotifier, AppState>((ref) {
  return AppNotifier();
});
