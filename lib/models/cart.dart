import 'package:flutter/foundation.dart';
import 'product.dart';

class CartItem {
  final Product product;
  int quantity;
  final String? size;

  CartItem({required this.product, this.quantity = 1, this.size});
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void add(Product p, {int qty = 1, String? size}) {
    final existing = _items.where((i) => i.product.id == p.id && i.size == size).toList();
    if (existing.isNotEmpty) {
      existing.first.quantity += qty;
    } else {
      _items.add(CartItem(product: p, quantity: qty, size: size));
    }
    notifyListeners();
  }

  void remove(Product p, {String? size}) {
    _items.removeWhere((i) => i.product.id == p.id && i.size == size);
    notifyListeners();
  }

  void updateQuantity(Product p, int quantity, {String? size}) {
    final item = _items.firstWhere((i) => i.product.id == p.id && i.size == size, orElse: () => throw StateError('Not found'));
    item.quantity = quantity;
    if (item.quantity <= 0) {
      remove(p, size: size);
    }
    notifyListeners();
  }

  double get total => _items.fold(0.0, (sum, item) => sum + item.product.price * item.quantity);

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
