import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;

  const CartItemCard(
    this.item, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.orange,
          child: Text(
            '100,00',
            style: TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ),
        title: Text('Red Shirt'),
        subtitle: Text('Total R\$ 100,00'),
        trailing: Text('3x'),
      ),
    );
  }
}
