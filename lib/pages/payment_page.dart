import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../services/payment_service.dart';
import '../widgets/header.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
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

  Future<void> _pay(BuildContext context) async {
    final cart = context.read<CartModel>();
    if (cart.items.isEmpty) return;

    if (_paymentMethod == 'card') {
      if (_cardNumberCtrl.text.trim().isEmpty || _cardNameCtrl.text.trim().isEmpty || _cardExpCtrl.text.trim().isEmpty || _cardCvvCtrl.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter valid card details')));
        return;
      }
    }

    setState(() => _processing = true);
    final success = await PaymentService.processPayment(
      method: _paymentMethod,
      card: _paymentMethod == 'card'
          ? {
              'number': _cardNumberCtrl.text.trim(),
              'name': _cardNameCtrl.text.trim(),
              'exp': _cardExpCtrl.text.trim(),
              'cvv': _cardCvvCtrl.text.trim(),
            }
          : null,
      amount: cart.total,
    );
    setState(() => _processing = false);

    if (success) {
      cart.clear();
      await showDialog(
        context: context,
        builder: (c) => AlertDialog(
          title: const Text('Payment successful'),
          content: const Text('Thank you — your order has been placed.'),
          actions: [TextButton(onPressed: () => Navigator.of(c).pop(), child: const Text('OK'))],
        ),
      );
      // Pop back to previous screen (cart or home)
      if (mounted) Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment failed — please try again')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Order Summary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...cart.items.map((item) => ListTile(
                        title: Text(item.product.title),
                        subtitle: Text('Qty: ${item.quantity}${item.size != null ? ' • Size: ${item.size}' : ''}'),
                        trailing: Text('£${(item.product.price * item.quantity).toStringAsFixed(2)}'),
                      )),
                  const Divider(),
                  Text('Total: £${cart.total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),

                  const Text('Payment method', style: TextStyle(fontWeight: FontWeight.bold)),
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

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: cart.items.isEmpty || _processing ? null : () => _pay(context),
                      child: _processing ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Pay now'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
