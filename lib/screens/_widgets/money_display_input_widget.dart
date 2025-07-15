import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackautomat_2502/domain/state/app_notifier.dart';
import 'package:snackautomat_2502/theme/theme_extentions.dart';

/// Widget representing the money display input case of the snackautomate
class MoneyDisplayInputWidget extends ConsumerWidget {
  /// Regular constructor
  const MoneyDisplayInputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appNotifierProvider);

    final currentCreditInCents = appState.input.value;
    final currentCreditInEuro = currentCreditInCents / 100.0;
    final displayText =
        'Guthaben: ${currentCreditInEuro.toStringAsFixed(2)} €'; // Formatierter Anzeigetext

    return ColoredBox(
      color: context.appColors.moneyDisplayInputBackground,
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
