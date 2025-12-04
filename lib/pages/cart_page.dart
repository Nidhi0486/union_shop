import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../widgets/header.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _processing = false;
  String _paymentMethod = 'card';
  final _cardNumberCtrl = TextEditingController();
  final _cardNameCtrl = TextEditingController();
  final _cardExpCtrl = TextEditingController();
  final _cardCvvCtrl = TextEditingController();

  @override
  void dispose() {
    _cardNumberCtrl.dispose();
    _cardNameCtrl.dispose();
    _cardExpCtrl.dispose();
    _cardCvvCtrl.dispose();
    super.dispose();
  }

  // Checkout handled inline in UI; no separate _checkout method required

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    final total = cart.total;
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
                  ...cart.items.map((item) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
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
                        trailing: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () => context.read<CartModel>().updateQuantity(item.product, item.quantity - 1, size: item.size),
                                ),
                                Text('${item.quantity}'),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () => context.read<CartModel>().updateQuantity(item.product, item.quantity + 1, size: item.size),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () => context.read<CartModel>().remove(item.product, size: item.size),
                              child: const Text('Remove', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 12),
                  Text('Total: £${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),

                  // Payment method selection
                  const Align(alignment: Alignment.centerLeft, child: Text('Payment method', style: TextStyle(fontWeight: FontWeight.bold)) ),
                  const SizedBox(height: 8),
                  Row(children: [
                    Radio<String>(value: 'card', groupValue: _paymentMethod, onChanged: (v) => setState(() => _paymentMethod = v!)),
                    const Text('Card'),
                    const SizedBox(width: 12),
                    Radio<String>(value: 'paypal', groupValue: _paymentMethod, onChanged: (v) => setState(() => _paymentMethod = v!)),
                    const Text('PayPal'),
                    const SizedBox(width: 12),
                    Radio<String>(value: 'cod', groupValue: _paymentMethod, onChanged: (v) => setState(() => _paymentMethod = v!)),
                    const Text('Cash on delivery'),
                  ]),
                  const SizedBox(height: 12),

                  if (_paymentMethod == 'card') ...[
                    TextField(controller: _cardNameCtrl, decoration: const InputDecoration(labelText: 'Name on card')),
                    const SizedBox(height: 8),
                    TextField(controller: _cardNumberCtrl, decoration: const InputDecoration(labelText: 'Card number'), keyboardType: TextInputType.number),
                    const SizedBox(height: 8),
                    Row(children: [
                      Expanded(child: TextField(controller: _cardExpCtrl, decoration: const InputDecoration(labelText: 'MM/YY'))),
                      const SizedBox(width: 8),
                      SizedBox(width: 120, child: TextField(controller: _cardCvvCtrl, decoration: const InputDecoration(labelText: 'CVV'), keyboardType: TextInputType.number)),
                    ]),
                    const SizedBox(height: 12),
                  ] else if (_paymentMethod == 'paypal') ...[
                    const Text('You will be redirected to PayPal to complete the payment (simulated).'),
                    const SizedBox(height: 12),
                  ] else ...[
                    const Text('Pay with cash on delivery.'),
                    const SizedBox(height: 12),
                  ],

                  // Simple checkout button: place order and clear cart
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: cart.items.isEmpty
                          ? null
                          : () async {
                              // validate card details if card selected
                              if (_paymentMethod == 'card') {
                                if (_cardNumberCtrl.text.trim().isEmpty || _cardNameCtrl.text.trim().isEmpty || _cardExpCtrl.text.trim().isEmpty || _cardCvvCtrl.text.trim().isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter valid card details')));
                                  return;
                                }
                              }
                              setState(() => _processing = true);
                              await Future.delayed(const Duration(seconds: 1));
                              setState(() => _processing = false);
                              context.read<CartModel>().clear();
                              showDialog(
                                context: context,
                                builder: (c) => AlertDialog(
                                  title: const Text('Order placed!'),
                                  content: const Text('Thank you — your order has been placed.'),
                                  actions: [TextButton(onPressed: () => Navigator.of(c).pop(), child: const Text('OK'))],
                                ),
                              );
                            },
                      child: _processing ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Checkout'),
                    ),
                  ),
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
