import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/productModel.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _items = [
    ProductModel(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      image:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    ProductModel(
        id: 'p2',
        title: 'Trousers',
        description: 'A nice pair of trousers.',
        price: 59.99,
        image:
            'https://image.shutterstock.com/image-photo/light-grey-formal-mens-trousers-260nw-1096296503.jpg')
  ];
  bool showFavOnly = false;

  List<ProductModel> get items {
    return [..._items];
  }

  List<ProductModel> get favItem {
    return _items.where((element) => element.isFav == true).toList();
  }

  ProductModel findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void addProduct(ProductModel product) {
    final newProduct = ProductModel(
        id: DateTime.now().toString(),
        title: product.title,
        description: product.description,
        image: product.image,
        price: product.price);
    _items.add(newProduct);
    notifyListeners();
  }

  void updateProduct(String id, ProductModel newProduct) {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }
  void deleteProduct(String id){
    _items.removeWhere((element) => element.id! == id);
    notifyListeners();
  }
}
