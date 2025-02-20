import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/http_exception_error.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        Routes.PRODUCT_FORM,
        arguments: product,
      ),
      child: ListTile(
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
                    title: Text('Excluir produto'),
                    content: Text(
                        'Tem certeza que quer remover o produto ${product.name} ?'),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            try {
                              await Provider.of<ProductList>(
                                context,
                                listen: false,
                              ).removeProduct(product);

                              if (context.mounted) {
                                notificationMessage(context, null);
                              }
                            } on HttpExceptionError catch (error) {
                              if (context.mounted) {
                                notificationMessage(context, error.toString());
                              }
                            } finally {
                              if (context.mounted) Navigator.of(context).pop();
                            }
                          },
                          child: Text('Sim')),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Não'),
                      )
                    ],
                  ),
                ),
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void notificationMessage(BuildContext context, String? errorMsg) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: errorMsg == null
          ? Text('Produto deletado com sucesso!!')
          : Text(errorMsg),
      backgroundColor: errorMsg == null ? Colors.green[700] : Colors.red[700],
      duration: Duration(seconds: 2),
    ),
  );
}
