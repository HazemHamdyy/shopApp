import 'package:flutter/material.dart';
import 'package:shop_app/models/productModel.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cartProvider.dart';
import 'package:shop_app/screens/productDetailsScreen.dart';

class ProductWidget extends StatelessWidget {
  // final String? id;
  // final String? title;
  // final String? image;

  // ProductWidget(
  //     {@required this.id, @required this.title, @required this.image});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductModel>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(id: product.id!)));
          },
          child: Image.network(
            product.image!,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: Consumer<ProductModel>(
            builder: (ctx, product, child) => IconButton(
              icon: Icon(Icons.favorite),
              color: product.isFav! ? Colors.red : Colors.white,
              onPressed: () {
                product.toggleFavStatus();
              },
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product.id!, product.title!, product.price!);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                'Added Item to Cart!',
                textAlign: TextAlign.center,
              ),
              duration: Duration(seconds: 2),
              action: SnackBarAction(label: 'UNDO', onPressed: (){
                cart.removeSingleItem(product.id!);
              }),
              ));
            },
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
          ),
          backgroundColor: Colors.black87,
          title: Text(
            product.title!,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
