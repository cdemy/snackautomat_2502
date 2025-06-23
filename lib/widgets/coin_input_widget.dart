import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackautomat_2502/state/app_notifier.dart';

class CoinInputWidget extends ConsumerWidget {
  const CoinInputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<double> coinValues = [0.10, 0.20, 0.50, 1.00, 2.00];

    return Container(
      color: Colors.purple[200],
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          alignment: WrapAlignment.center,
          children: coinValues.map((value) {
            return ElevatedButton(
              onPressed: () {
                ref.read(appNotifierProvider.notifier).addCredit(value);
              },
              child: Text(
                '${value.toStringAsFixed(2)} €',
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
