import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackautomat_2502/domain/state/app_notifier.dart';
// import 'package:snackautomat_2502/domain/state/app_state.dart';

class MoneyDisplayOutputWidget extends ConsumerWidget {
  const MoneyDisplayOutputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Beobachtet änderungen im AppState
    final appState = ref.watch(appNotifierProvider);

    final appNotifier = ref.read(appNotifierProvider.notifier);

    final totalUsersBalanceInCents =
        appState.input.value + appState.output.value;
    final totalUsersBalanceInEuro = totalUsersBalanceInCents / 100.0;
    String displayText;
    if (totalUsersBalanceInEuro > 0) {
      displayText =
          'Rückgeld: ${totalUsersBalanceInEuro.toStringAsFixed(2)} €'; // Anzeige des Rückgeldes
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
                // "Buy" button
                ElevatedButton(
                  // Button is only active if product is selected and sufficient credit is available
                  onPressed:
                      (appState.selectedSnack != null &&
                          totalUsersBalanceInCents >=
                              appState.selectedSnack!.price)
                      ? () {
                          // Complete the purchase process
                          appNotifier.doTransaction();
                        }
                      : null, // Deactivates the button if conditions are not met

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey[400],
                    disabledForegroundColor: Colors.grey[700],
                  ),
                  child: Text(
                    'Kaufen',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),

                // “Withdraw money” button
                ElevatedButton(
                  // Button ist nur aktiv, wenn das aktuelle Guthaben drauf ist
                  onPressed: totalUsersBalanceInEuro > 0
                      ? () {
                          appNotifier.returnCredit();
                        }
                      : null, // Deactivates the button if there is no credit
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey[400],
                    disabledForegroundColor: Colors.grey[700],
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
