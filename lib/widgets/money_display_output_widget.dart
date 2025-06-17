// MoneyDisplayOutput Widget

import 'package:flutter/material.dart';

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
