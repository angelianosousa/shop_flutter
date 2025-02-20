import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/application/main_drawer.dart';
import 'package:shop/components/manager/product_item.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/routes.dart';

class ProductsIndex extends StatelessWidget {
  const ProductsIndex({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(Routes.PRODUCT_FORM),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (ctx, i) {
            return Column(
              children: [
                ProductItem(products.items[i]),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
