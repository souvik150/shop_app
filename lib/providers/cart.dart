import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items == null ? 0 : _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price + cartItem.quantity;
    });
    return total;
  }

  void addItem(
      String productId,
      double price,
      String title,
      ) {
    if (_items!= null && _items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
            (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      if (_items!= null) {
        _items.putIfAbsent(
          productId,
              () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: 1,
          ),
        );
      }
    }
    notifyListeners();
  }
}