import 'package:flutter/material.dart';
import 'package:shop_app/models/cartModel.dart';

class OrderModel {
  final String? id;
  final double? amount;
  final List<CartModel>? products;
  final DateTime? dateTime;

  OrderModel({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}