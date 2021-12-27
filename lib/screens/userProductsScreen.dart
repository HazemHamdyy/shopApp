import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/productProvider.dart';
import 'package:shop_app/screens/editingProductScreen.dart';
import 'package:shop_app/widgets/drawerWidget.dart';
import 'package:shop_app/widgets/userProductWidget.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('My Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditingProductScreen(null)));
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                UserProductWidget(
                  id: productsData.items[index].id!,
                  title: productsData.items[index].title!,
                  image: productsData.items[index].image!,
                ),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
