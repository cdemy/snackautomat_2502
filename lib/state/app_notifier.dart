// app_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackauotmat_2502/state/app_state.dart';

class AppNotifier extends StateNotifier<AppState> {
  AppNotifier()
    : super(
        const AppState(
          availableSnacks: [
            // Preise jetzt in Cents
            Snack(
              id: '1',
              name: 'Schokolade',
              price: 150,
              quantity: 10,
            ), // 1.50 € = 150 Cents
            Snack(
              id: '2',
              name: 'Chips',
              price: 120,
              quantity: 5,
            ), // 1.20 € = 120 Cents
            Snack(
              id: '3',
              name: 'Cola',
              price: 200,
              quantity: 8,
            ), // 2.00 € = 200 Cents
          ],
        ),
      );

  void addCredit(double amount) {
    if (amount <= 0) return;

    final int amountInCents = (amount * 100).round();
    state = state.copyWith(currentCredit: state.currentCredit + amountInCents);
    print(
      'Guthaben hinzugefügt: $amount. Neues Guthaben: ${state.currentCredit / 100}', // Zur Anzeige zurück in Euro konvertieren
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
        'Nicht genug Guthaben für "${snack.name}". Benötigt: ${snack.price / 100}, Aktuell: ${state.currentCredit / 100}', // Zur Anzeige konvertieren
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
        'Nicht genug Guthaben für "${snackToPurchase.name}". Benötigt: ${snackToPurchase.price / 100}, Aktuell: ${state.currentCredit / 100}', // Zur Anzeige konvertieren
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
      '"${snackToPurchase.name}" gekauft. Restguthaben: ${state.currentCredit / 100}', // Zur Anzeige konvertieren
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
        // Preise wieder in Cents
        Snack(id: '1', name: 'Schokolade', price: 150, quantity: 10),
        Snack(id: '2', name: 'Chips', price: 120, quantity: 5),
        Snack(id: '3', name: 'Cola', price: 200, quantity: 8),
      ],
    );
    print('Snackautomat zurückgesetzt.');
  }
}

final appNotifierProvider = StateNotifierProvider<AppNotifier, AppState>((ref) {
  return AppNotifier();
});
