import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import '../models/product.dart';
import '../models/cart.dart';

class PersonalisationPage extends StatefulWidget {
  const PersonalisationPage({Key? key}) : super(key: key);

  @override
  State<PersonalisationPage> createState() => _PersonalisationPageState();
}

class _PersonalisationPageState extends State<PersonalisationPage> {
  String _text = 'Your text';
  double _fontSize = 28.0;
  Color _color = Colors.white;
  String _sampleImage = 'assets/images/tshirt.png';
  String _selectedProduct = 'T-shirt';

  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = _text;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('The Print Shack — Personalisation', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  const Text('Personalise your product with custom text. Type below, pick a colour and size, and see a live preview.'),
                  const SizedBox(height: 16),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left: Controls
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Enter text to print', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _textController,
                              onChanged: (v) => setState(() => _text = v),
                              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'e.g. N. Smith'),
                            ),
                            const SizedBox(height: 12),
                            const Text('Choose product', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            DropdownButton<String>(
                              value: _selectedProduct,
                              items: const [
                                DropdownMenuItem(value: 'T-shirt', child: Text('T-shirt')),
                                DropdownMenuItem(value: 'Hoodie', child: Text('Hoodie')),
                                DropdownMenuItem(value: 'Notebook', child: Text('Notebook')),
                              ],
                              onChanged: (v) {
                                if (v == null) return;
                                setState(() {
                                  _selectedProduct = v;
                                  if (v == 'Hoodie') _sampleImage = 'assets/images/hoodie1.jpg';
                                  if (v == 'T-shirt') _sampleImage = 'assets/images/tshirt.png';
                                  if (v == 'Notebook') _sampleImage = 'assets/images/Notebook.png';
                                });
                              },
                            ),
                            const Text('Font size', style: TextStyle(fontWeight: FontWeight.bold)),
                            Slider(value: _fontSize, min: 12, max: 64, divisions: 26, label: _fontSize.round().toString(), onChanged: (v) => setState(() => _fontSize = v)),
                            const SizedBox(height: 8),
                            const Text('Colour', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Row(children: [
                              _colorSwatch(Colors.white),
                              const SizedBox(width: 8),
                              _colorSwatch(Colors.black),
                              const SizedBox(width: 8),
                              _colorSwatch(Colors.red),
                              const SizedBox(width: 8),
                              _colorSwatch(Colors.blue),
                              const SizedBox(width: 8),
                              _colorSwatch(Colors.green),
                            ]),

                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                // create a Product with the personalisation metadata encoded in the id/title
                                final p = Product(
                                  id: 'personalised:${_text}:${_fontSize}:${_color.value}',
                                  title: 'Personalised item - ${_text.isEmpty ? 'Custom' : _text}',
                                  description: 'Personalised with "${_text}"',
                                  price: 25.0,
                                  imageUrl: _sampleImage,
                                );
                                Provider.of<CartModel>(context, listen: false).add(p, qty: 1);
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Personalised item added to cart (£25)')));
                              },
                              child: const Text('Add personalised product to cart — £25'),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Right: Live preview
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Container(
                            width: 360,
                            height: 420,
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(_sampleImage, fit: BoxFit.cover, errorBuilder: (c, e, st) => Container(color: Colors.grey[200])),
                                ),
                                // text preview centered
                                Center(
                                  child: Text(
                                    _text.isEmpty ? 'Your text' : _text,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: _fontSize, color: _color, fontWeight: FontWeight.bold, shadows: [const Shadow(blurRadius: 2, color: Colors.black26)]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _colorSwatch(Color c) {
    return GestureDetector(
      onTap: () => setState(() => _color = c),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(6), border: Border.all(color: _color == c ? Colors.black : Colors.grey.shade300, width: _color == c ? 2 : 1)),
      ),
    );
  }
}
