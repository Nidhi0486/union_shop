import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import '../widgets/network_image_fallback.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, String> product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = product['title'] ?? 'Product';
    final price = product['price'] ?? '£0.00';
    final image = product['image'] ?? 'https://via.placeholder.com/800x800';

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
                  SizedBox(
                    height: 360,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: NetworkImageWithFallback(url: image, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(price, style: const TextStyle(fontSize: 20, color: Color(0xFF4d2963), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  const Text('This is a hardcoded description for the dummy product. Replace with real data when available.', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          items: const [
                            DropdownMenuItem(value: 'S', child: Text('S')),
                            DropdownMenuItem(value: 'M', child: Text('M')),
                            DropdownMenuItem(value: 'L', child: Text('L')),
                          ],
                          onChanged: (_) {},
                          decoration: const InputDecoration(labelText: 'Size'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          items: const [
                            DropdownMenuItem(value: 'Red', child: Text('Red')),
                            DropdownMenuItem(value: 'Blue', child: Text('Blue')),
                            DropdownMenuItem(value: 'Green', child: Text('Green')),
                          ],
                          onChanged: (_) {},
                          decoration: const InputDecoration(labelText: 'Colour'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
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
