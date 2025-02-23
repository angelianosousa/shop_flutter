import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart';
import 'package:shop/utils/services.dart';

class OrderList with ChangeNotifier {
  final String _tokenAuth;
  final String _userId;
  List<Order> _items = [];

  OrderList([
    this._tokenAuth = '',
    this._userId = '',
    this._items = const [],
  ]);

  List<Order> get items => [..._items];

  int get itemsCount => items.length;

  Future<void> loadOrders() async {
    List<Order> items = [];

    final response = await http
        .get(Uri.parse('${Services.baseUrl}/orders/$_userId.json?auth=$_tokenAuth'));

    if (response.body == 'null') return;

    jsonDecode(response.body).forEach(
      (orderId, orderData) => items.add(Order(
        id: orderId,
        totalFinal: orderData['totalFinal'],
        createdAt: DateTime.parse(orderData['createdAt']),
        products: (orderData['products'] as List<dynamic>).map((item) {
          return CartItem(
            id: item['id'],
            productId: item['productId'],
            name: item['name'],
            quantity: item['quantity'],
            price: item['price'],
          );
        }).toList(),
      )),
    );

    _items = items.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();

    final response = await http.post(
      Uri.parse('${Services.baseUrl}/orders/$_userId.json?auth=$_tokenAuth'),
      body: jsonEncode({
        'totalFinal': cart.totalAmount,
        'createdAt': date.toIso8601String(),
        'products': cart.items.values
            .map(
              (item) => {
                'id': item.id,
                'name': item.name,
                'price': item.price,
                'productId': item.productId,
                'quantity': item.quantity,
              },
            )
            .toList(),
      }),
    );

    final id = jsonDecode(response.body)['name'];

    _items.insert(
      0,
      Order(
        id: id,
        totalFinal: cart.totalAmount,
        products: cart.items.values.toList(),
        createdAt: date,
      ),
    );

    notifyListeners();
  }
}
