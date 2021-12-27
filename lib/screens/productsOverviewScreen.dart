import 'package:flutter/material.dart';
import 'package:shop_app/models/productModel.dart';
import 'package:shop_app/provider/cartProvider.dart';
import 'package:shop_app/provider/productProvider.dart';
import 'package:shop_app/screens/cartScreen.dart';
import 'package:shop_app/widgets/badgeWidget.dart';
import 'package:shop_app/widgets/drawerWidget.dart';
import 'package:shop_app/widgets/productWidget.dart';
import 'package:shop_app/widgets/productsGridWidget.dart';
import 'package:provider/provider.dart';

enum filterOption {
  favourite,
  showAll,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool showFav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
              onSelected: (filterOption i) {
                setState(() {
                  if (i == filterOption.favourite) {
                    showFav = true;
                  } else if (i == filterOption.showAll) {
                    showFav = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Favourite'),
                      value: filterOption.favourite,
                    ),
                    PopupMenuItem(
                      child: Text('Show all'),
                      value: filterOption.showAll,
                    )
                  ]),
          Consumer<CartProvider>(
              builder: (_, cartData, child) => Badge(
                  child: child,
                  
                  value: cartData.itemsCount.toString()),
                  child: IconButton(
                    onPressed: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartScreen()));
                    },
                    icon: Icon(Icons.shopping_cart),
                  ),)
        ],
      ),
      drawer: DrawerWidget(),
      body: ProductsGridWidget(showFav),
    );
  }
}
