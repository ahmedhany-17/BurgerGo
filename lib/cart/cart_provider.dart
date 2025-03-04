import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  double get totalPrice {
    return _cartItems.fold(0, (total, item) => total + (item['price'] * item['quantity']));
  }

  void addToCart(Map<String, dynamic> product) {
    int index = _cartItems.indexWhere((item) => item['name'] == product['name']);

    if (index != -1) {
      _cartItems[index]['quantity']++;
    } else {
      _cartItems.add({...product, "quantity": 1});
    }

    notifyListeners();
  }

  void increaseQuantity(int index) {
    _cartItems[index]['quantity']++;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_cartItems[index]['quantity'] > 1) {
      _cartItems[index]['quantity']--;
    } else {
      _cartItems.removeAt(index);
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}