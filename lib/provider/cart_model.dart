import 'package:exam/page/products.dart';
import 'package:flutter/material.dart';

import 'dart:collection';



class CartItem {
  final Products product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _products = [];

  List<CartItem> get products => _products;
UnmodifiableListView<CartItem> get productsList => UnmodifiableListView(_products);

  
void addProduct(Products product) {
    final index = _products.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _products[index].quantity++; 
    } else {
      _products.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeProduct(Products product) {
    _products.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  void increaseQuantity(Products product) {
    final index = _products.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _products[index].quantity++;
    }
    notifyListeners();
  }
  
  void decreaseQuantity(Products product) {
    final index = _products.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _products[index].quantity--;
      if (_products[index].quantity <= 0) {
        _products.removeAt(index);
      }
    }
    notifyListeners();
  }
}