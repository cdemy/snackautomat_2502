import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackautomat_2502/screens/main/_widgets/products_view_widget.dart';
import 'package:snackautomat_2502/screens/main/_widgets/money_display_input_widget.dart';
import 'package:snackautomat_2502/screens/main/_widgets/money_display_price_widget.dart';
import 'package:snackautomat_2502/screens/main/_widgets/coin_input_widget.dart';
import 'package:snackautomat_2502/screens/main/_widgets/money_display_output_widget.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainScreen(),
    ),
  );
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vending Machine MVP',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: VendingMachineScreen(),
    );
  }
}

class VendingMachineScreen extends StatelessWidget {
  const VendingMachineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vending Machine'),
      ),
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
                    flex: 2,
                    child: CoinInputWidget(),
                  ),
                  SizedBox(height: 8),
                  // Anzeige des Geldes im Restschacht
                  Expanded(
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
