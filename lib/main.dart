import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return ChangeNotifierProvider(
      create: (_) => ProductList(),
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
        home: ProductsPage(),
        debugShowCheckedModeBanner: false,
        routes: {
          Routes.PRODUCT_DETAIL: (ctx) => ProductDetail(),
        },
      ),
    );
  }
}
