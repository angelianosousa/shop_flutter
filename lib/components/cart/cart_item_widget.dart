import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget(
    this.item, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.only(right: 20.0),
        color: Colors.red,
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Remover Item do Carrinho'),
            content: Text('Tem certeza que quer remover o item ${item.name} ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text('Sim'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text('Não'),
              )
            ],
          ),
        );
      },
      onDismissed: (_) =>
          Provider.of<Cart>(context, listen: false).removeItem(item.productId),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              item.price.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          ),
          title: Text(
            item.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('Total R\$ ${item.totalAmount}'),
          trailing: Text('${item.quantity}x'),
        ),
      ),
    );
  }
}
