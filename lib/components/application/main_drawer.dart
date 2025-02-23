import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
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
            title: Text('Welcome to My Store!!'),
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Provider.of<Auth>(context, listen: false).signOut();
                Navigator.of(context).pushReplacementNamed(Routes.indexPage);
              },
              icon: Icon(Icons.logout),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_bag_outlined),
            title: Text('Produtos'),
            subtitle: Text('Seus itens a um clique'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(Routes.indexPage),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.dns_outlined),
            title: Text('Pedidos'),
            subtitle: Text('Acompanha suas demandas'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(Routes.ordersPage),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit_note),
            title: Text('Gerenciar produtos'),
            subtitle: Text('Organize seus produtos'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(Routes.productsPage),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            subtitle: Text('Sair do aplicativo'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).signOut();
              Navigator.of(context).pushReplacementNamed(Routes.indexPage);
            },
          ),
        ],
      ),
    );
  }
}
