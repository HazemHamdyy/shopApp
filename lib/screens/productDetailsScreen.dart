import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/productProvider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String? id;
  // final String? title;
  // final String? image;

  ProductDetailsScreen({
    @required this.id,
    // @required this.title,
    // @required this.image
  });

  @override
  Widget build(BuildContext context) {
    final loadedProduct =
        Provider.of<ProductProvider>(context, listen: false).findById(id!);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(loadedProduct.title!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.image!,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${loadedProduct.price} LE',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(loadedProduct.description!,textAlign: TextAlign.center,softWrap: true,)
          ],
        ),
      ),
    );
  }
}
