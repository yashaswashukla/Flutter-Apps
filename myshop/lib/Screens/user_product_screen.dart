import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../Widgets/user_product_item.dart';
import '../Widgets/app_drawer.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user_product_screen';

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(
                productData.items[i].id,
                productData.items[i].title,
                productData.items[i].imageUrl,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
