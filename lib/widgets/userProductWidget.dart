import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/productProvider.dart';
import 'package:shop_app/screens/editingProductScreen.dart';

class UserProductWidget extends StatelessWidget {
  final String? id;
  final String? title;
  final String? image;

  UserProductWidget({@required this.title, @required this.image,@required this.id});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title!),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(image!),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditingProductScreen(id)));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                Provider.of<ProductProvider>(context,listen: false).deleteProduct(id!);
              },
            )
          ],
        ),
      ),
    );
  }
}
