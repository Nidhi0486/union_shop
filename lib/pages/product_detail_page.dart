import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/cart.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import '../widgets/network_image_fallback.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String? _selectedSize;
  String? _selectedColor;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _selectedSize = 'M';
    _selectedColor = 'Purple';
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final title = product['title'] ?? 'Product';
    final price = product['price'] ?? '£0.00';
    final images = product['images'];
    final image = (images is List && images.isNotEmpty) ? images[0] as String : (product['image'] ?? 'https://via.placeholder.com/800x800');

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
                  FocusableActionDetector(
                    enabled: false,
                    mouseCursor: SystemMouseCursors.basic,
                    child: SizedBox(
                      height: 360,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Builder(builder: (c) {
                          if (images is List && images.isNotEmpty) {
                            return PageView(
                              children: images.map<Widget>((img) {
                                if ((img).startsWith('assets/')) {
                                  return Image.asset(
                                    img,
                                    fit: BoxFit.cover,
                                    errorBuilder: (ctx, e, st) => Center(
                                      child: Text('Image not found', style: TextStyle(color: Colors.grey[600])),
                                    ),
                                  );
                                }
                                return NetworkImageWithFallback(url: img, fit: BoxFit.cover);
                              }).toList(),
                            );
                          }

                          if ((image).startsWith('assets/')) {
                            return Image.asset(
                              image,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, e, st) => Center(
                                child: Text('Image not found', style: TextStyle(color: Colors.grey[600])),
                              ),
                            );
                          }

                          return NetworkImageWithFallback(url: image, fit: BoxFit.cover);
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(price, style: const TextStyle(fontSize: 20, color: Color(0xFF4d2963), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  const Text('This is a hardcoded description for the dummy product. Replace with real data when available.', style: TextStyle(color: Colors.pink)),
                  const SizedBox(height: 16),
                  // Show size and colour only for clothing items
                  Builder(builder: (ctx) {
                    final titleLower = title.toString().toLowerCase();
                    final showVariants = titleLower.contains('hoodie') || titleLower.contains('t-shirt') || titleLower.contains('tshirt') || titleLower.contains('shirt') || titleLower.contains('tee');
                    if (!showVariants) return const SizedBox.shrink();
                    return Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedSize,
                            items: const [
                              DropdownMenuItem(value: 'XS', child: Text('XS')),
                              DropdownMenuItem(value: 'S', child: Text('S')),
                              DropdownMenuItem(value: 'M', child: Text('M')),
                              DropdownMenuItem(value: 'L', child: Text('L')),
                              DropdownMenuItem(value: 'XL', child: Text('XL')),
                            ],
                            onChanged: (v) => setState(() => _selectedSize = v),
                            decoration: const InputDecoration(labelText: 'Size'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedColor,
                            items: const [
                              DropdownMenuItem(value: 'Purple', child: Text('Purple')),
                              DropdownMenuItem(value: 'Pink', child: Text('Pink')),
                              DropdownMenuItem(value: 'Red', child: Text('Red')),
                              DropdownMenuItem(value: 'Blue', child: Text('Blue')),
                              DropdownMenuItem(value: 'Green', child: Text('Green')),
                              DropdownMenuItem(value: 'Black', child: Text('Black')),
                              DropdownMenuItem(value: 'White', child: Text('White')),
                              DropdownMenuItem(value: 'Grey', child: Text('Grey')),
                              DropdownMenuItem(value: 'Yellow', child: Text('Yellow')),
                            ],
                            onChanged: (v) => setState(() => _selectedColor = v),
                            decoration: const InputDecoration(labelText: 'Colour'),
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text('Quantity:'),
                      const SizedBox(width: 8),
                      IconButton(icon: const Icon(Icons.remove), onPressed: () => setState(() { if (_quantity>1) _quantity--; })),
                      Text('$_quantity'),
                      IconButton(icon: const Icon(Icons.add), onPressed: () => setState(() => _quantity++)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Create a Product instance and add to CartModel
                      final priceValue = double.tryParse((price as String).replaceAll(RegExp(r'[^0-9\.]'), '')) ?? 0.0;
                      final p = Product(
                        id: title.toString(),
                        title: title.toString(),
                        description: '',
                        price: priceValue,
                        imageUrl: image as String,
                      );
                      final titleLower = title.toString().toLowerCase();
                      final showVariants = titleLower.contains('hoodie') || titleLower.contains('t-shirt') || titleLower.contains('tshirt') || titleLower.contains('shirt') || titleLower.contains('tee');
                      Provider.of<CartModel>(context, listen: false).add(p, qty: _quantity, size: showVariants ? _selectedSize : null);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart')));
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      child: Text('Add to Cart'),
                    ),
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
}
