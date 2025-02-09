import 'package:flutter/material.dart';
import 'package:shop/utils/routes.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          AppBar(
            title: Text('Welcome!!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_bag_outlined),
            title: Text('Produtos'),
            subtitle: Text('Seus itens a um clique'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(Routes.HOME),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.dns_outlined),
            title: Text('Pedidos'),
            subtitle: Text('Acompanha suas demandas'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(Routes.ORDERS),
          ),
          Divider(),
        ],
      ),
    );
  }
}
