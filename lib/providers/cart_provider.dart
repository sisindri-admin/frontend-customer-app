import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final String unit;
  int quantity;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    this.unit = '1 unit',
    this.quantity = 1,
    required this.imageUrl,
  });
}

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.values.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  double get deliveryFee => subtotal > 199 || subtotal == 0 ? 0.0 : 25.0;

  double get totalAmount => subtotal + deliveryFee;

  int getItemQuantity(String id) => _items[id]?.quantity ?? 0;

  void addItem(String id, String title, double price, String unit, String imageUrl) {
    if (_items.containsKey(id)) {
      _items[id]!.quantity += 1;
    } else {
      _items[id] = CartItem(
        id: id,
        title: title,
        price: price,
        unit: unit,
        imageUrl: imageUrl,
      );
    }
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) return;
    if (_items[id]!.quantity > 1) {
      _items[id]!.quantity -= 1;
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}