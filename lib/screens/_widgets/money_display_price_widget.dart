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
    final price = appState.selectedSnack?.price;

    String displayPriceText;
    if (price != null && price > 0) {
      displayPriceText = 'Gesamt: ${(price / 100).toStringAsFixed(2)} €';
    } else {
      displayPriceText = 'leer';
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
