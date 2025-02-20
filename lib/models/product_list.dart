import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems => _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount => _items.length;

  void addProduct(Product item) {
    _items.add(item);
    notifyListeners();
  }

  void saveProduct(Map<String, Object> productData) {
    bool hasId = productData['id'] != null;

    final product = Product(
      id: hasId ? productData['id'] as String : Random().nextDouble().toString(),
      name: productData['name'] as String,
      description: productData['description'] as String,
      imageUrl: productData['imageUrl'] as String,
      price: productData['price'] as double,
    );

    if (hasId) {
      updateProduct(product);
    } else {
      _items.add(product);
    }
    
    notifyListeners();
  }

  void updateProduct(Product product) {
    int index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) _items[index] = product;

    notifyListeners();
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) _items.removeWhere((prod) => prod.id == product.id);

    notifyListeners();
  }
}

// bool _showFavoriteOnly = false;

// List<Product> get items {
//   if(_showFavoriteOnly) _items.where((prod) => prod.isFavorite).toList( );

//   return [..._items];
// }

// void showFavoriteOnly() {
//   _showFavoriteOnly = true;
//   notifyListeners();
// }

// void showAll() {
//   _showFavoriteOnly = false;
//   notifyListeners();
// }