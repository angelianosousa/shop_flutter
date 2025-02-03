import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_resume.dart';
import 'package:shop/models/cart.dart';
// import 'package:shop/components/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CartResume(cart.totalAmount),
            SizedBox(height: 15),
            // ListView.builder(
            //   itemCount: cart.itemsCount,
            //   itemBuilder: (ctx, index) {
            //   return CartItemCard(cart.items[index]!);
            // }),
          ],
        ),
      ),
    );
  }
}




