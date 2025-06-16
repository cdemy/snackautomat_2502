import 'package:flutter/material.dart';

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
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Placeholder(
        child: Center(
          child: Text(
            'ProductsView',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}

// MoneyDisplayInput Widget
class MoneyDisplayInput extends StatelessWidget {
  const MoneyDisplayInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[200],
      child: Placeholder(
        child: Center(
          child: Text(
            'MoneyDisplayInput',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}

// MoneyDisplayPrice Widget
class MoneyDisplayPrice extends StatelessWidget {
  const MoneyDisplayPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange[200],
      child: Placeholder(
        child: Center(
          child: Text(
            'MoneyDisplayPrice',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}

// CoinInput Widget
class CoinInput extends StatelessWidget {
  const CoinInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple[200],
      child: Placeholder(
        child: Center(
          child: Text(
            'CoinInput',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}

// MoneyDisplayOutput Widget
class MoneyDisplayOutput extends StatelessWidget {
  const MoneyDisplayOutput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[200],
      child: Placeholder(
        child: Center(
          child: Text(
            'MoneyDisplayOutput',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
