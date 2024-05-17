import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cart = [];

  List<Map<String, dynamic>> get cart => _cart;

  void addOrUpdateCart(Map<String, dynamic> product) {
    final existingItemIndex = _cart.indexWhere((item) =>
        item['name'] == product['name'] &&
        item['category'] == product['category'] &&
        (item['size'] == product['size'] || product['size'] == null));

    if (existingItemIndex != -1) {
      _cart[existingItemIndex]['quantity'] += product['quantity'];
    } else {
      _cart.add(product);
    }
    notifyListeners();
  }

  void updateQuantity(String name, String category, int quantity, {String? size}) {
    final itemIndex =
        _cart.indexWhere((item) => item['name'] == name && item['category'] == category && (item['size'] == size || size == null));

    if (itemIndex != -1) {
      _cart[itemIndex]['quantity'] = quantity;
      notifyListeners();
    }
  }

  void removeFromCart(String name, String category, {String? size}) {
    _cart.removeWhere((item) => item['name'] == name && item['category'] == category && (item['size'] == size || size == null));
    print(_cart.length);
    notifyListeners();
  }

  int getTotalQuantity() {
    if (_cart.isEmpty) return 0;
    return _cart.map((e) => e['quantity']).reduce((value, element) => value + element);
  }

  double getTotalPrice() {
    if (_cart.isEmpty) return 0;
    return _cart.fold(0, (sum, item) => sum + item['price'] * item['quantity']);
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
