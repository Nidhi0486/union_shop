import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../widgets/header.dart';
import 'payment_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    final total = cart.total;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
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
                    ...cart.items.map((item) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          isThreeLine: true,
                          leading: (item.product.imageUrl.startsWith('assets/'))
                              ? Image.asset(item.product.imageUrl, width: 56, height: 56, fit: BoxFit.cover, errorBuilder: (c, e, st) => const Icon(Icons.image))
                              : Image.network(item.product.imageUrl, width: 56, height: 56, fit: BoxFit.cover),
                          title: Text(item.product.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (item.size != null) Text('Size: ${item.size}', style: const TextStyle(fontSize: 12)),
                              const SizedBox(height: 4),
                              Text('Price: £${item.product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 13)),
                            ],
                          ),
                          trailing: SizedBox(
                            width: 120,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                      iconSize: 20,
                                      icon: const Icon(Icons.remove_circle_outline),
                                      onPressed: () => context.read<CartModel>().updateQuantity(item.product, item.quantity - 1, size: item.size),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                      child: Text('${item.quantity}', style: const TextStyle(fontSize: 14)),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                      iconSize: 20,
                                      icon: const Icon(Icons.add_circle_outline),
                                      onPressed: () => context.read<CartModel>().updateQuantity(item.product, item.quantity + 1, size: item.size),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(40, 28), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                                  onPressed: () => context.read<CartModel>().remove(item.product, size: item.size),
                                  child: const Text('Remove', style: TextStyle(color: Colors.red, fontSize: 13)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 12),
                    Text('Total: £${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: cart.items.isEmpty
                            ? null
                            : () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PaymentPage()));
                              },
                        child: const Text('Checkout'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(onPressed: () => context.read<CartModel>().clear(), child: const Text('Clear cart')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
