import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception_error.dart';
import 'package:shop/utils/services.dart';
import 'product.dart';

class ProductList with ChangeNotifier {
  final String _tokenAuth;
  final String _userId;
  List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  ProductList([
    this._tokenAuth = '',
    this._userId = '',
    this._items = const [],
  ]);

  int get itemsCount => _items.length;

  Future<void> loadProducts() async {
    _items.clear();

    final response = await http.get(
      Uri.parse('${Services.baseUrl}/products.json?auth=$_tokenAuth'),
    );

    if (response.body == 'null') return;

    final userFavorities = await http.get(
      Uri.parse(
        '${Services.baseUrl}/userFavorite/$_userId.json?auth=$_tokenAuth',
      ),
    );

    Map<String, dynamic> favoritiesData =
        userFavorities == 'null' ? {} : jsonDecode(userFavorities.body);

    final productList = jsonDecode(response.body);

    productList.forEach((prodId, prodData) {
      final isFavorite = favoritiesData[prodId] ?? false;

      _items.add(
        Product(
          id: prodId,
          name: prodData['name'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavorite: isFavorite,
        ),
      );
    });

    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> productData) {
    bool hasId = productData['id'] != null;

    final product = Product(
      id: hasId
          ? productData['id'] as String
          : Random().nextDouble().toString(),
      name: productData['name'] as String,
      description: productData['description'] as String,
      imageUrl: productData['imageUrl'] as String,
      price: productData['price'] as double,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('${Services.baseUrl}/products.json?auth=$_tokenAuth'),
      body: jsonEncode({
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
      }),
    );

    final id = jsonDecode(response.body)['name'];

    _items.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    ));

    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse(
            '${Services.baseUrl}/products/${product.id}.json?auth=$_tokenAuth'),
        body: jsonEncode({
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        }),
      );

      _items[index] = product;
    }

    notifyListeners();

    return Future.value();
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      _items.removeWhere((prod) => prod.id == product.id);
      notifyListeners();

      final response = await http.delete(Uri.parse(
          '${Services.baseUrl}/products/${product.id}.json?auth=$_tokenAuth'));

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpExceptionError(
          msg: 'Não foi possível excluir o produto',
          statusCode: response.statusCode,
        );
      }
    }
  }
}
