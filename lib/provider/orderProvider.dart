import 'package:flutter/material.dart';
import 'package:shop_app/models/orderModel.dart';
import 'package:shop_app/models/cartModel.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> _orders = [];

  List<OrderModel> get orders {
    return [..._orders];
  }

  void addOrder(List<CartModel> cartProducts, double total) {
    _orders.insert(0, OrderModel(id: DateTime.now().toString(),amount: total,dateTime: DateTime.now(),products: cartProducts));
    notifyListeners();
  }
}
