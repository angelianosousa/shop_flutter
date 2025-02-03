import 'package:flutter/material.dart';

class CartResume extends StatelessWidget {
  final String totalAmount;

  const CartResume(
    this.totalAmount, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 10,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Chip(
                  
                  label: Text(
                    totalAmount,
                    style: TextStyle(
                      color: Theme.of(context)
                          .primaryTextTheme
                          .headlineMedium
                          ?.color,
                    ),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                
              ],
            ),
            TextButton(
              onPressed: () {},
              child: Text('Comprar'),
            ),
          ],
        ),
      ),
    );
  }
}
