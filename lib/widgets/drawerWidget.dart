import 'package:flutter/material.dart';
import 'package:shop_app/screens/orderScreen.dart';
import 'package:shop_app/screens/productsOverviewScreen.dart';
import 'package:shop_app/screens/userProductsScreen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProductsOverviewScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('My Orders'),
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OrderScreen()));
            },
          ),
           Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UserProductsScreen()));
            },
          ),

        ],
      ),
      
    );
  }
}