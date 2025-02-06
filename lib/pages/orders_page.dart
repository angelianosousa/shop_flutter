import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/application/main_drawer.dart';
import 'package:shop/components/order/order_widget..dart';
import 'package:shop/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of<OrderList>(context);
    final items = orders.items;

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (ctx, i) {
          return OrderWidget(order: items[i]);
        },
      ),
    );
  }
}
