import 'package:flutter/material.dart';
import 'package:snackauotmat_2502/theme/theme_extentions.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return VendingMachineScreen();
  }
}

class VendingMachineScreen extends StatelessWidget {
  const VendingMachineScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Linke zwei Drittel: ProductsView
            Expanded(
              flex: 2,
              child: ProductsView(),
            ),
            SizedBox(width: 16),
            // Rechtes Drittel: Control Panel
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  // Anzeige des eingeworfenen Betrags
                  Expanded(
                    flex: 1,
                    child: MoneyDisplayInput(),
                  ),
                  SizedBox(height: 8),
                  // Anzeige des nötigen Betrages
                  Expanded(
                    flex: 1,
                    child: MoneyDisplayPrice(),
                  ),
                  SizedBox(height: 8),
                  // Fläche für Buttons mit Münzen
                  Expanded(
                    flex: 1,
                    child: CoinInput(),
                  ),
                  SizedBox(height: 8),
                  // Anzeige des Geldes im Restschacht
                  Expanded(
                    flex: 1,
                    child: MoneyDisplayOutput(),
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

// ProductsView Widget
class ProductsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appColors.productsViewBackground,
      child: Placeholder(
        child: Center(
          child: Text(
            'ProductsView',
          ),
        ),
      ),
    );
  }
}

// MoneyDisplayInput Widget
class MoneyDisplayInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appColors.moneyDisplayInputBackground,
      child: Placeholder(
        child: Center(
          child: Text(
            'MoneyDisplayInput',
          ),
        ),
      ),
    );
  }
}

// MoneyDisplayPrice Widget
class MoneyDisplayPrice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange[200],
      child: Placeholder(
        child: Center(
          child: Text(
            'MoneyDisplayPrice',
          ),
        ),
      ),
    );
  }
}

// CoinInput Widget
class CoinInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple[200],
      child: Placeholder(
        child: Center(
          child: Text(
            'CoinInput',
          ),
        ),
      ),
    );
  }
}

// MoneyDisplayOutput Widget
class MoneyDisplayOutput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[200],
      child: Placeholder(
        child: Center(
          child: Text(
            'MoneyDisplayOutput',
          ),
        ),
      ),
    );
  }
}
