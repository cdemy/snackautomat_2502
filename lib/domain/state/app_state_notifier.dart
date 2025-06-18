import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackautomat_2502/domain/state/app_state.dart';
import 'package:snackautomat_2502/models/snack.dart';

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier()
    : super(
        const AppState(
          availableSnacks: [
            Snack(id: '1', name: 'Schokolade', price: 150, quantity: 10),
            Snack(id: '2', name: 'Chips', price: 120, quantity: 5),
            Snack(id: '3', name: 'Cola', price: 200, quantity: 8),
          ],
        ),
      );

  void addCredit(double amount) {
    if (amount <= 0) return;
    final int amountInCents = (amount * 100).round();
    state = state.copyWith(currentCredit: state.currentCredit + amountInCents);
    print(
      'Guthaben hinzugefügt: $amount. Neues Guthaben: ${state.currentCredit / 100}',
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
        'Nicht genug Guthaben für "${snack.name}". Benötigt: ${snack.price / 100}, Aktuell: ${state.currentCredit / 100}',
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
        'Nicht genug Guthaben für "${snackToPurchase.name}". Benötigt: ${snackToPurchase.price / 100}, Aktuell: ${state.currentCredit / 100}',
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
      '"${snackToPurchase.name}" gekauft. Restguthaben: ${state.currentCredit / 100}',
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
        Snack(id: '1', name: 'Schokolade', price: 150, quantity: 10),
        Snack(id: '2', name: 'Chips', price: 120, quantity: 5),
        Snack(id: '3', name: 'Cola', price: 200, quantity: 8),
      ],
      currentCredit: 0,
      selectedSnackId: null,
    );
    print('Snackautomat zurückgesetzt.');
  }

  void returnCredit() {
    if (state.currentCredit > 0) {
      final returnedAmountInEuro = state.currentCredit / 100.0;
      state = state.copyWith(currentCredit: 0);
      print(
        'Guthaben zurückgegeben: ${returnedAmountInEuro.toStringAsFixed(2)} €',
      );
      print('Neues Guthaben: ${state.currentCredit / 100} €');
    } else {
      print('Kein Guthaben zum Zurückgeben vorhanden.');
    }
    state = state.copyWith(selectedSnackId: null);
  }
}
