import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackauotmat_2502/state/app_state.dart';
import 'package:snackauotmat_2502/state/cart_item.dart';

class AppNotifier extends StateNotifier<AppState> {
  AppNotifier()
    : super(
        const AppState(
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
          cartItems: [],
        ),
      );

  void addCredit(double amount) {
    if (amount <= 0) return;
    final int amountInCents = (amount * 100)
        .round(); // Konvertiert Euro in Cents und rundet auf

    state = state.copyWith(currentCredit: state.currentCredit + amountInCents);
    print(
      'Guthaben hinzugefügt: $amount. Neues Guthaben: ${state.currentCredit / 100}',
    );
  }

  void incrementSnackInCart(String snackId) {
    final snackInStock = state.availableSnacks.firstWhere(
      (s) => s.id == snackId,
      orElse: () => throw Exception(
        'Snack not found in stock',
      ),
    );

    final existingCartItemIndex = state.cartItems.indexWhere(
      (item) => item.snack.id == snackId,
    );
    List<CartItem> updatedCart = List.from(
      state.cartItems,
    );

    if (existingCartItemIndex != -1) {
      final existingCartItem = updatedCart[existingCartItemIndex];

      if (snackInStock.quantity <= existingCartItem.quantity) {
        print(
          'Snack "${snackInStock.name}" ist in maximaler Menge im Warenkorb (Bestand erschöpft).',
        );
        return;
      }
      // Aktualisiert die Menge des Produkts im warenkorb
      updatedCart[existingCartItemIndex] = existingCartItem.copyWith(
        quantity: existingCartItem.quantity + 1,
      );
    } else {
      if (snackInStock.quantity == 0) {
        print(
          'Snack "${snackInStock.name}" ist ausverkauft und kann nicht hinzugefügt werden.',
        );
        return;
      }
      // Fügt ein neuen Snack in den Warenkorb ein
      updatedCart.add(CartItem(snack: snackInStock, quantity: 1));
    }

    state = state.copyWith(cartItems: updatedCart);
    print('Menge von "${snackInStock.name}" im Warenkorb erhöht.');
  }

  void decrementSnackInCart(String snackId) {
    final existingCartItemIndex = state.cartItems.indexWhere(
      (item) => item.snack.id == snackId,
    );

    if (existingCartItemIndex != -1) {
      final existingCartItem = state.cartItems[existingCartItemIndex];
      List<CartItem> updatedCart = List.from(
        state.cartItems,
      );

      if (existingCartItem.quantity > 1) {
        updatedCart[existingCartItemIndex] = existingCartItem.copyWith(
          quantity: existingCartItem.quantity - 1,
        );
        print(
          'Menge von "${existingCartItem.snack.name}" im Warenkorb verringert auf ${existingCartItem.quantity - 1}.',
        );
      } else {
        updatedCart.removeAt(existingCartItemIndex);
        print(
          'Snack "${existingCartItem.snack.name}" aus dem Warenkorb entfernt.',
        );
      }

      state = state.copyWith(cartItems: updatedCart);
    }
  }

  int get cartTotalPrice {
    return state.cartItems.fold(
      0,
      (sum, item) => sum + (item.snack.price * item.quantity),
    );
  }

  void purchaseCart() {
    if (state.cartItems.isEmpty) {
      print('Warenkorb ist leer. Keine Artikel zum Kaufen.');
      return;
    }

    final totalCost = cartTotalPrice;

    // Prüft ob genug guthaben drauf ist
    if (state.currentCredit < totalCost) {
      print(
        'Nicht genug Guthaben für den Einkauf. Benötigt: ${totalCost / 100} €, Aktuell: ${state.currentCredit / 100} €',
      );
      return;
    }

    final Map<String, int> requiredQuantities = {};
    for (var cartItem in state.cartItems) {
      requiredQuantities.update(
        cartItem.snack.id,
        (value) => value + cartItem.quantity,
        ifAbsent: () => cartItem.quantity,
      );
    }

    // Prüft ob es genug Snacks gibt
    for (var entry in requiredQuantities.entries) {
      final snackId = entry.key;
      final needed = entry.value;

      final availableInStock = state.availableSnacks
          .firstWhere((s) => s.id == snackId)
          .quantity;

      if (availableInStock < needed) {
        print(
          'Fehler: "${state.availableSnacks.firstWhere((s) => s.id == snackId).name}" ist nicht in ausreichender Menge ($needed benötigt, $availableInStock verfügbar) vorhanden.',
        );
        return; // Kauf abbrechen
      }
    }

    // Wenn alles stimmt, kann der kauf durchgeführt werden
    // Reduziert die Menge der gekauften Snacks im Lagerbestand
    final updatedAvailableSnacks = state.availableSnacks.map((stockSnack) {
      final purchasedQuantity = requiredQuantities[stockSnack.id] ?? 0;
      if (purchasedQuantity > 0) {
        return stockSnack.copyWith(
          quantity: stockSnack.quantity - purchasedQuantity,
        );
      }
      return stockSnack;
    }).toList();

    final newCredit =
        state.currentCredit - totalCost; // Berechnet das neue Guthaben

    // Aktualisiert den AppState nach dem Kauf
    state = state.copyWith(
      availableSnacks: updatedAvailableSnacks,
      currentCredit: newCredit,
      cartItems: [],
    );

    print(
      'Einkauf erfolgreich! Gesamtkosten: ${totalCost / 100} €. Restguthaben: ${state.currentCredit / 100} €',
    );
  }

  void clearCart() {
    if (state.cartItems.isNotEmpty) {
      state = state.copyWith(cartItems: []);
      print('Warenkorb geleert.');
    }
  }

  void resetVendingMachine() {
    state = const AppState(
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
      currentCredit: 0,
      cartItems: [],
    );
    print('Snackautomat zurückgesetzt.');
  }

  void returnCredit() {
    if (state.currentCredit > 0) {
      final returnedAmountInEuro = state.currentCredit / 100.0;
      state = state.copyWith(
        currentCredit: 0,
      );
      print(
        'Guthaben zurückgegeben: ${returnedAmountInEuro.toStringAsFixed(2)} €',
      );
      print('Neues Guthaben: ${state.currentCredit / 100} €');
    } else {
      print('Kein Guthaben zum Zurückgeben vorhanden.');
    }
    state = state.copyWith(
      cartItems: [],
    ); // Leert auch den Warenkorb bei Geldentnahme
  }
}

final appNotifierProvider = StateNotifierProvider<AppNotifier, AppState>((ref) {
  return AppNotifier();
});
