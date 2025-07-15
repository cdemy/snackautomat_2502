import 'package:flutter/material.dart';
import 'package:snackautomat_2502/screens/_widgets/coin_input_widget.dart';
import 'package:snackautomat_2502/screens/_widgets/money_display_input_widget.dart';
import 'package:snackautomat_2502/screens/_widgets/money_display_output_widget.dart';
import 'package:snackautomat_2502/screens/_widgets/money_display_price_widget.dart';
import 'package:snackautomat_2502/screens/_widgets/products_view_widget.dart';
import 'package:snackautomat_2502/theme/theme_extentions.dart';

/// Widget Main Screen of the App
class MainScreen extends StatelessWidget {
  /// Regular constructor
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
      body: const Padding(
        padding: EdgeInsets.all(
          16,
        ),
        child: Row(
          children: [
            // Linke zwei Drittel: ProductsView
            Expanded(
              flex: 2,
              child: ProductsViewWidget(),
            ),
            SizedBox(
              width: 16,
            ),

            // Rechtes Drittel: Control Panel
            Expanded(
              child: Column(
                children: [
                  // Anzeige des eingeworfenen Betrags
                  Expanded(
                    child: MoneyDisplayInputWidget(),
                  ),
                  SizedBox(height: 8),

                  // Anzeige des nötigen Betrages
                  Expanded(
                    child: MoneyDisplayPriceWidget(),
                  ),
                  SizedBox(height: 8),

                  // Fläche für Buttons mit Münzen
                  Expanded(
                    child: CoinInputWidget(),
                  ),
                  SizedBox(height: 8),

                  // Anzeige des Geldes im Restschacht
                  Expanded(
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
