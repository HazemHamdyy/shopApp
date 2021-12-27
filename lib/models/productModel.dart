import 'package:flutter/foundation.dart';

class ProductModel with ChangeNotifier {
  final String? id;
  final String? title;
  final double? price;
  final String? description;
  final String? image;
  bool? isFav;

  ProductModel(
      {@required this.id,
      @required this.description,
      @required  this.title,
      @required  this.image,
      @required  this.price,
      this.isFav=false});

  void toggleFavStatus() {
    isFav = !isFav!;
    notifyListeners();
  }
}
