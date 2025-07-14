import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackautomat_2502/domain/state/app_notifier.dart';
import 'package:snackautomat_2502/models/coinstack.dart';
import 'package:snackautomat_2502/theme/theme_extentions.dart';

/// Widget representing the coin input case of the snackautomate
class CoinInputWidget extends ConsumerWidget {
  /// Regular constructor
  const CoinInputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: context.appColors.coinInputWidgetBackground,
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: CoinStack.potentialCoinValues.map((value) {
            return ElevatedButton(
              onPressed: () {
                ref.read(appNotifierProvider.notifier).addInput(value);
              },
              child: Text(
                '${(value / 100).toStringAsFixed(2)} €',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
