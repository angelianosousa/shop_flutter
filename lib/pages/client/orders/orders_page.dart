import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/application/main_drawer.dart';
import 'package:shop/components/order/order_widget..dart';
import 'package:shop/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      body: FutureBuilder(
        future: Provider.of<OrderList>(context, listen: false).loadOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Consumer<OrderList>(
              builder: (ctx, orders, child) => ListView.builder(
                itemCount: orders.itemsCount,
                itemBuilder: (ctx, i) {
                  return OrderWidget(order: orders.items[i]);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
