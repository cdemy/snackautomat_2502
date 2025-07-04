import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackautomat_2502/domain/state/app_notifier.dart';
import 'package:snackautomat_2502/theme/theme_extentions.dart';

class MoneyDisplayPriceWidget extends ConsumerWidget {
  const MoneyDisplayPriceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Widget reagiert auf Zustandsänderungen
    final appState = ref.watch(appNotifierProvider);
    final price = appState.selectedSnack?.price;
    final name = appState.selectedSnack?.name;

    String displayPriceText;
    if (price != null && price > 0) {
      displayPriceText = '$name: ${(price / 100).toStringAsFixed(2)} €';
    } else {
      displayPriceText = "Select Snack";
    }

    return Container(
      // color: Colors.orange[200],
      color: context.appColors.moneyDisplayPriceBackground,
      child: Center(
        child: Text(
          appState.displayMessage ?? displayPriceText,
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
