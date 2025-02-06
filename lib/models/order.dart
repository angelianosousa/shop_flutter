import 'package:shop/models/cart_item.dart';

class Order {
  final String id;
  final double totalFinal;
  final List<CartItem> products;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.totalFinal,
    required this.products,
    required this.createdAt,
  });
}
