import 'package:flutter/material.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
// Alle Widgets (importiert)
import 'package:snackauotmat_2502/widgets/products_view_widget.dart';
import 'package:snackauotmat_2502/widgets/money_display_input_widget.dart';
import 'package:snackauotmat_2502/widgets/money_display_price_widget.dart';
import 'package:snackauotmat_2502/widgets/coin_input_widget.dart';
import 'package:snackauotmat_2502/widgets/money_display_output_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vending Machine',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          16.0,
        ),
        child: Row(
          children: [
            const Expanded(
              flex: 2,
              child: ProductsViewWidget(),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  const Expanded(
                    flex: 1,
                    child: MoneyDisplayInputWidget(),
                  ),
                  const SizedBox(height: 8),

                  const Expanded(
                    flex: 1,
                    child: MoneyDisplayPriceWidget(),
                  ),
                  const SizedBox(height: 8),

                  const Expanded(
                    flex: 2,
                    child: CoinInputWidget(),
                  ),
                  const SizedBox(height: 8),

                  const Expanded(
                    flex: 1,
                    child: MoneyDisplayOutputWidget(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
