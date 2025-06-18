import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackauotmat_2502/state/app_notifier.dart';

class MoneyDisplayOutputWidget extends ConsumerWidget {
  const MoneyDisplayOutputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Beobachtet änderungen im AppState
    final appState = ref.watch(appNotifierProvider);

    final appNotifier = ref.read(appNotifierProvider.notifier);

    final currentCreditInCents = appState.currentCredit;
    final currentCreditInEuro = currentCreditInCents / 100.0;

    final totalCartPriceInCents = appNotifier.cartTotalPrice;

    String displayText;
    if (currentCreditInEuro > 0) {
      displayText =
          'Rückgeld: ${currentCreditInEuro.toStringAsFixed(2)} €'; // Anzeige des Rückgeldes
    } else {
      displayText =
          'Rückgabe / Rückgeld'; // Text wenn kein Geld eingeworfen wurde
    }

    return Container(
      color: Colors.red[200],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              displayText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // "Kaufen"-Button
                ElevatedButton(
                  // Button ist  aktiv, wenn der Warenkorb nicht leer ist und Geld eingeworfen wurde
                  onPressed:
                      appState.cartItems.isNotEmpty &&
                          currentCreditInCents >= totalCartPriceInCents
                      ? () {
                          appNotifier.purchaseCart();
                        }
                      : null, // Deaktiviert den Button, wenn die Bedingungen nicht erfüllt sind
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Kaufen',
                    style: TextStyle(fontSize: 14),
                  ),
                ),

                // "Geld entnehmen"-Button
                ElevatedButton(
                  // Button ist nur aktiv, wenn das aktuelle Guthaben drauf ist
                  onPressed: currentCreditInEuro > 0
                      ? () {
                          appNotifier.returnCredit();
                        }
                      : null, // Deaktiviert den Button, wenn kein Guthaben drauf ist
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Geld entnehmen',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
