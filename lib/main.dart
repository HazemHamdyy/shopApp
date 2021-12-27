import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cartModel.dart';
import 'package:shop_app/provider/cartProvider.dart';
import 'package:shop_app/provider/orderProvider.dart';
import 'package:shop_app/provider/productProvider.dart';
import 'package:shop_app/screens/productsOverviewScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers :
    [
      ChangeNotifierProvider(
      // value: ProductProvider(),
      create: (context) => ProductProvider(),),
      ChangeNotifierProvider(
      // value: ProductProvider(),
      create: (context) => CartProvider(),),
       ChangeNotifierProvider(
      // value: ProductProvider(),
      create: (context) => OrderProvider(),),
    ],
      child: MaterialApp(
        title: 'My Shop App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amberAccent ,
          fontFamily: 'Lato',
    
        ),
        debugShowCheckedModeBanner: false,
        home:ProductsOverviewScreen()
      )
    );
  }
}

