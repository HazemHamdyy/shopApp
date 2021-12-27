import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cartProvider.dart';

class CartWidget extends StatelessWidget {
  final String? id;
  final String? productID;
  final double? price;
  final int? quantity;
  final String? title;

  CartWidget({
    @required this.id,
    @required this.productID,
    @required this.price,
    @required this.quantity,
    @required this.title,}
  );


  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        Provider.of<CartProvider>(context,listen: false).removeItem(productID!);
      },
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
        return showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Are You Sure ?'),
            content: Text('Do You Want to Delete The Item from The Cart?'),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop(false);
              }, child: Text('No')),
              TextButton(onPressed: (){
                 Navigator.of(context).pop(true);
              }, child: Text('Yes')),
            ],
          );
        });
      },
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        child : Icon(Icons.delete,
        color: Colors.white),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
        child: Padding(padding: EdgeInsets.all(10),
        child: ListTile(
          leading: CircleAvatar(child: FittedBox(child: Text('${price!}  LE')),),
          title: Text(title!),
          subtitle: Text('Total : ${price!*quantity!} LE'),
          trailing: Text('x${quantity!}'),
        ),),
        
      ),
    );
  }
}