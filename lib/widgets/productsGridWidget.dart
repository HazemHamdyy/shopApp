import 'package:flutter/material.dart';
import 'package:shop_app/models/productModel.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/productProvider.dart';
import 'package:shop_app/widgets/productWidget.dart';

class ProductsGridWidget extends StatelessWidget {
  final bool? showFav;
  ProductsGridWidget(this.showFav);
  

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final products = showFav==false? productData.items: productData.favItem;
    return GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return ChangeNotifierProvider.value(
              value: products[index],
              // create: (context) =>  products[index],
              child: ProductWidget(
                // id: products[index].id,
                // title: products[index].title,
                // image: products[index].image,
              ),
            );
          });
  }
}