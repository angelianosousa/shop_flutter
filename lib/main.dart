import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/pages/app_widget.dart';
import 'package:shop/pages/client/carts/cart_page.dart';
import 'package:shop/pages/client/orders/orders_page.dart';
import 'package:shop/pages/client/home/product_detail.dart';

import 'package:shop/models/product_list.dart';
import 'package:shop/pages/manager/product_form.dart';
import 'package:shop/pages/manager/products_index.dart';
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
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(),
          update: (ctx, auth, previous) {
            return ProductList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (ctx, auth, previous) {
            return OrderList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'My Store',
        theme: ThemeData(
          fontFamily: 'Lato',
          primaryColor: Colors.teal[700],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.teal[700],
            centerTitle: true,
            foregroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          Routes.indexPage: (ctx) => AppWidget(),
          Routes.cartPage: (ctx) => CartPage(),
          Routes.ordersPage: (ctx) => OrdersPage(),
          Routes.productsPage: (ctx) => ProductsIndex(),
          Routes.productDetailPage: (ctx) => ProductDetail(),
          Routes.productForm: (ctx) => ProductForm(),
        },
      ),
    );
  }
}
