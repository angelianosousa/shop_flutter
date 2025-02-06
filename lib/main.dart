import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_detail.dart';

import 'package:shop/pages/products_page.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        )
      ],
      child: MaterialApp(
        title: 'My Store',
        theme: ThemeData(
          fontFamily: 'Lato',
          primaryColor: Colors.red,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.red,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          Routes.HOME: (ctx) => ProductsPage(),
          Routes.PRODUCT_DETAIL: (ctx) => ProductDetail(),
          Routes.CART_PAGE: (ctx) => CartPage(),
          Routes.ORDERS: (ctx) => OrdersPage(),
        },
      ),
    );
  }
}
