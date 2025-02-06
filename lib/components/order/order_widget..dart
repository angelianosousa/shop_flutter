import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/order.dart';

class OrderWidget extends StatefulWidget {
  final Order order;
  const OrderWidget({
    required this.order,
    super.key,
  });

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expandItem = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'R\$ ${widget.order.totalFinal.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyy hh:mm').format(widget.order.createdAt),
            ),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expandItem = !_expandItem;
                });
              },
            ),
          ),
          if (_expandItem)
            Container(
              // color: Colors.grey[400],
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              height: 60 * widget.order.products.length.toDouble(),
              child: ListView(
                children: widget.order.products.map((product) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                              '${product.quantity} x R\$${product.price.toStringAsFixed(2)}')
                        ],
                      ),
                      Text(
                        'R\$${(product.quantity * product.price).toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                }).toList(),
              ),
            )
        ],
      ),
    );
  }
}
