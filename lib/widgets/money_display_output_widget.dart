import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackauotmat_2502/state/app_notifier.dart';

class MoneyDisplayOutputWidget extends ConsumerWidget {
  const MoneyDisplayOutputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appNotifierProvider);
    final appNotifier = ref.read(appNotifierProvider.notifier);

    final currentCreditInCents = appState.currentCredit;
    final currentCreditInEuro = currentCreditInCents / 100.0;

    String displayText;
    if (currentCreditInEuro > 0) {
      displayText = 'Rückgeld: ${currentCreditInEuro.toStringAsFixed(2)} €';
    } else {
      displayText = 'Rückgeld';
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
            if (currentCreditInEuro > 0) const SizedBox(height: 8),
            if (currentCreditInEuro > 0)
              ElevatedButton(
                onPressed: () {
                  appNotifier.returnCredit();
                },
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
      ),
    );
  }
}
