// CoinInput Widget

import 'package:flutter/material.dart';

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
