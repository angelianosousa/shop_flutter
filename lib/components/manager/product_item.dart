import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(
        product.name,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(product.description),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  Routes.PRODUCT_FORM,
                  arguments: product,
                );
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              color: Colors.red,
              onPressed: () => showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Remover produto'),
                  content: Text(
                      'Tem certeza que quer remover o produto ${product.name} ?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Provider.of<ProductList>(context, listen: false)
                              .removeProduct(product);
                          Navigator.of(context).pop();
                          notificationMessage(context);
                        },
                        child: Text('Sim')),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Não'))
                  ],
                ),
              ),
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}

void notificationMessage(BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Produto deletado com sucesso!!'),
      backgroundColor: Colors.green[700],
      duration: Duration(seconds: 2),
    ),
  );
}
