import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackautomat_2502/domain/state/app_notifier.dart';

class MoneyDisplayInputWidget extends ConsumerWidget {
  const MoneyDisplayInputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appNotifierProvider);

    final currentCreditInCents = appState.input.value;
    final currentCreditInEuro = currentCreditInCents / 100.0;
    final displayText =
        'Guthaben: ${currentCreditInEuro.toStringAsFixed(2)} €'; // Formatierter Anzeigetext

    return Container(
      color: Colors.green[200],
      child: Center(
        child: Text(
          displayText, // Zeigt das aktuelle Guthaben an
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
