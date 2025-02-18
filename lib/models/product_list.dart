import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];

  void addProduct(Product item) {
    _items.add(item);
    notifyListeners();
  }
}