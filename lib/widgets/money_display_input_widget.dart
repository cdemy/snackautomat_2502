// MoneyDisplayInput Widget
import 'package:flutter/material.dart';

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
