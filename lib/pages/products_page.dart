import 'package:flutter/material.dart';
import 'package:shop/components/product_grid.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Store'),
      ),
      body: ProductGrid(),
    );
  }
}


