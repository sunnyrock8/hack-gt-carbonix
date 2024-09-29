import 'dart:collection';

import 'package:carbonix/models/product.model.dart';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List<Product> _products = [];

  UnmodifiableListView<Product> get products => UnmodifiableListView(_products);

  void add(Product product) {
    _products.add(product.copyWith(quantity: 1));

    notifyListeners();
  }

  void removeAll() {
    _products.clear();
  }

  void addPiece(String id) {
    int matchingProductIndex =
        _products.indexWhere((product) => product.id == id);
    if (matchingProductIndex < 0) return null;

    _products[matchingProductIndex] = _products[matchingProductIndex].copyWith(
        quantity: (_products[matchingProductIndex].quantity ?? 0) + 1);

    notifyListeners();
  }

  void reducePiece(String id) {
    int matchingProductIndex =
        _products.indexWhere((product) => product.id == id);
    if (matchingProductIndex < 0) return null;

    if (_products[matchingProductIndex].quantity == 1)
      remove(id);
    else
      _products[matchingProductIndex] = _products[matchingProductIndex]
          .copyWith(
              quantity: (_products[matchingProductIndex].quantity ?? 0) - 1);

    notifyListeners();
  }

  void remove(String id) {
    _products.removeWhere((product) => product.id == id);

    notifyListeners();
  }

  double getTotal() {
    double total = 0.0;

    _products.forEach((product) {
      total += product.price * (product.quantity ?? 1);
    });

    return total;
  }
}
