import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Screens/products_overview_screen.dart';
import './Screens/product_details_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/auth.dart';
import './Screens/cart_screen.dart';
import './providers/orders.dart';
import './Screens/orders_screen.dart';
import './Screens/user_product_screen.dart';
import './Screens/edit_product_screen.dart';
import './Screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //This value constructor is used when the data which we are passing does not depend on the context and hence we do not need the builder/create function
    //This value approach is better if we use it inside of a list or a grid
    //This ensures that the provider works even if the data changes of the widgets
    //If we are initiating any new class while calling the changeNotifierProvider then we should only use create function, not the value constructor
    //If we reuse any old class then we should use the value constructor
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.orange[100],
          fontFamily: 'Lato',
        ),
        home: AuthScreen(),
        routes: {
          ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          UserProductScreen.routeName: (ctx) => UserProductScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
