import 'package:flutter/foundation.dart';

class CartItem {
  final int productId;
  final String title;
  final int quantity;
  final double price;
  final double weight;
  CartItem({
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
    required this.weight,
  });
}

class Cart with ChangeNotifier {
  Map<int, CartItem> _items = {};
  Map<int, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartitem) {
      total += cartitem.price * cartitem.quantity;
    });
    return total;
  }

  double get totalWeight {
    var total = 0.0;
    _items.forEach((key, cartitem) {
      total += cartitem.weight * cartitem.quantity;
    });
    return total;
  }

  void addItem(int productId,String title,double price,int quantity,double weight) {
    if (!_items.containsKey(productId)) {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              productId: productId,
              title: title,
              quantity: quantity,
              price: price,
              weight: weight));
      notifyListeners();
    }
  }
void removeItem(int productId){
  if(_items.containsKey(productId)){
    _items.remove(productId);
  notifyListeners();
  }
}
void clear(){
  _items={};
  notifyListeners();
}
}
