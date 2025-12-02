import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../widgets/header.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('Your Cart', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  if (cart.items.isEmpty) const Text('Your cart is empty'),
                  ...cart.items.map((item) => ListTile(
                        leading: Image.network(item.product.imageUrl, width: 48, height: 48, fit: BoxFit.cover),
                        title: Text(item.product.title),
                        subtitle: Text('£${item.product.price.toStringAsFixed(2)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => context.read<CartModel>().updateQuantity(item.product, item.quantity - 1),
                            ),
                            Text('${item.quantity}'),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => context.read<CartModel>().updateQuantity(item.product, item.quantity + 1),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 12),
                  Text('Total: £${cart.total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ElevatedButton(onPressed: () => context.read<CartModel>().clear(), child: const Text('Clear cart')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
