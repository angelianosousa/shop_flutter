import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/application/main_drawer.dart';
import 'package:shop/components/badge_cart.dart';
import 'package:shop/components/home/product_grid.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/utils/routes.dart';

enum FilterOptions { favorite, all }

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool _showFavoriteOnly = false;

  void filterFavorites(FilterOptions selectedValue) {
    setState(() {
      if (selectedValue == FilterOptions.favorite) {
        _showFavoriteOnly = true;
      } else {
        _showFavoriteOnly = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('My Store'),
        actions: [
          PopupMenuButton(
            iconColor: Colors.white,
            itemBuilder: (_) => [
              PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text('Favoritos'),
              ),
              PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Todos'),
              )
            ],
            onSelected: filterFavorites,
          ),
          Consumer<Cart>(
            child: IconButton(
              color: Colors.white,
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.CART_PAGE),
              icon: Icon(Icons.shopping_cart),
            ),
            builder: (ctx, cart, child) => BadgeCart(
              textValue: cart.itemsCount.toString(),
              child: child!,
            ),
          ),
        ],
      ),
      body: ProductGrid(_showFavoriteOnly),
    );
  }
}
