import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/orderProvider.dart';
import 'package:shop_app/widgets/orderWidget.dart';
import 'package:shop_app/widgets/drawerWidget.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
      body: ListView.builder(
        itemCount: orders.orders.length,
        itemBuilder: (context,index) {
          return OrderWidget(orders.orders[index]);
        },
      )
    );
  }
}