import 'package:flutter/foundation.dart';
import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void add(Product p, {int qty = 1}) {
    final existing = _items.where((i) => i.product.id == p.id).toList();
    if (existing.isNotEmpty) {
      existing.first.quantity += qty;
    } else {
      _items.add(CartItem(product: p, quantity: qty));
    }
    notifyListeners();
  }

  void remove(Product p) {
    _items.removeWhere((i) => i.product.id == p.id);
    notifyListeners();
  }

  void updateQuantity(Product p, int quantity) {
    final item = _items.firstWhere((i) => i.product.id == p.id, orElse: () => throw StateError('Not found'));
    item.quantity = quantity;
    if (item.quantity <= 0) {
      remove(p);
    }
    notifyListeners();
  }

  double get total => _items.fold(0.0, (sum, item) => sum + item.product.price * item.quantity);

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
