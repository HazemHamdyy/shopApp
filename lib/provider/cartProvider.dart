import 'package:flutter/foundation.dart';
import 'package:shop_app/models/cartModel.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel>? _items = {};
  Map<String, CartModel> get items {
    return {..._items!};
  }

  int get itemsCount {
    return _items!.length;
  }

  double get totalPrice {
    double total = 0.0;
    _items!.forEach((key, value) {
      total += value.price! * value.quantity!;
    });
    return total;
  }

  void addItem(String productId, String title, double price) {
    if (_items!.containsKey(productId)) {
      _items!.update(
          productId,
          (value) => CartModel(
                id: value.id,
                title: value.title,
                price: value.price,
                quantity: value.quantity! + 1,
              ));
    } else {
      _items!.putIfAbsent(
          productId,
          () => CartModel(
                id: DateTime.now().toString(),
                title: title,
                price: price,
                quantity: 1,
              ));
    }
    notifyListeners();
  }

  void removeSingleItem(String productID) {
    if (!_items!.containsKey(productID)) {
      return;
    }
    if (_items![productID]!.quantity! > 1) {
      _items!.update(
          productID,
          (value) => CartModel(
              id: value.id,
              title: value.title,
              price: value.price,
              quantity: value.quantity! - 1));
              
    }else{ _items!.remove(productID);}
    
    notifyListeners();
  }

  void removeItem(String productID) {
    _items!.remove(productID);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
