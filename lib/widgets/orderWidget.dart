import 'package:flutter/material.dart';
import 'package:shop_app/models/orderModel.dart';
import 'package:shop_app/provider/orderProvider.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class OrderWidget extends StatefulWidget {
 final OrderModel? order;

 OrderWidget(this.order);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('${widget.order!.amount} LE'),
            subtitle: Text(DateFormat('dd MM yyyy hh:mm').format(widget.order!.dateTime!)),
            trailing: IconButton(
              icon: Icon(_expanded? Icons.expand_less: Icons.expand_more),
              onPressed: (){
                setState(() {
                  
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if(_expanded) Container(height: min(widget.order!.products!.length * 20.0+100,180),
          child: ListView.builder(
            itemCount: widget.order!.products!.length,
            itemBuilder: (context,index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.order!.products![index].title!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),),
                  Text('${widget.order!.products![index].quantity} x ${widget.order!.products![index].price} LE',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey
                  ),)
                ],
              );
            },
          ),),
        ],
      ),
      
    );
  }
}