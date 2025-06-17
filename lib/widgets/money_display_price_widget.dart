// MoneyDisplayPrice Widget

import 'package:flutter/material.dart';

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
