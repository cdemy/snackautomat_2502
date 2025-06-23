import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackautomat_2502/domain/state/app_notifier.dart';
// import 'package:snackauotmat_2502/state/app_state.dart';

class MoneyDisplayPriceWidget extends ConsumerWidget {
  const MoneyDisplayPriceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Widget reagiert auf Zustandsänderungen
    final appState = ref.watch(appNotifierProvider);

    // Berechne den Warenkorbpreis in Cents und €
    final totalCartPriceInCents = appState.cartItems.fold(
      0,
      (sum, item) => sum + (item.snack.price * item.quantity),
    );
    final totalCartPriceInEuro = totalCartPriceInCents / 100.0;

    String displayPriceText;
    if (totalCartPriceInEuro > 0) {
      displayPriceText = 'Gesamt: ${totalCartPriceInEuro.toStringAsFixed(2)} €';
    } else {
      displayPriceText = 'Warenkorb leer';
    }

    return Container(
      color: Colors.orange[200],
      child: Center(
        child: Text(
          displayPriceText,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
