import 'package:flutter/material.dart';

import '../Models/product.dart';
import '../Widgets/products_grid.dart';


class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: ProductsGrid(),
    );
  }
}
