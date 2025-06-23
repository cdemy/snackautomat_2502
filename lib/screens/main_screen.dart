import 'package:flutter/material.dart';
import 'package:snackautomat_2502/screens/_widgets/products_view_widget.dart';
import 'package:snackautomat_2502/screens/_widgets/money_display_input_widget.dart';
import 'package:snackautomat_2502/screens/_widgets/money_display_price_widget.dart';
import 'package:snackautomat_2502/screens/_widgets/coin_input_widget.dart';
import 'package:snackautomat_2502/screens/_widgets/money_display_output_widget.dart';

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
            // Linke zwei Drittel: ProductsView
            const Expanded(
              flex: 2,
              child: ProductsViewWidget(),
            ),
            const SizedBox(
              width: 16,
            ),

            // Rechtes Drittel: Control Panel
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  // Anzeige des eingeworfenen Betrags
                  const Expanded(
                    flex: 1,
                    child: MoneyDisplayInputWidget(),
                  ),
                  const SizedBox(height: 8),

                  // Anzeige des nötigen Betrages
                  const Expanded(
                    flex: 1,
                    child: MoneyDisplayPriceWidget(),
                  ),
                  const SizedBox(height: 8),

                  // Fläche für Buttons mit Münzen
                  const Expanded(
                    flex: 1,
                    child: CoinInputWidget(),
                  ),
                  const SizedBox(height: 8),

                  // Anzeige des Geldes im Restschacht
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
