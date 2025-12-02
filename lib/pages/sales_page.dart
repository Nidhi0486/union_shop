import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import '../widgets/product_card.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = List.generate(4, (i) {
      final original = 30 + i * 10;
      final sale = (original * 0.7).toStringAsFixed(2);
      return {
        'title': 'Sale Product ${i + 1}',
        'original': '£$original.00',
        'price': '£$sale',
        'image': 'https://via.placeholder.com/400x400'
      };
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('Sales', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: products.map((p) {
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/product'),
                        child: Stack(
                          children: [
                            ProductCardSmall(
                              title: p['title']!,
                              price: p['price']!,
                              imageUrl: p['image']!,
                              onTap: null,
                            ),
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                                child: const Text('SALE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              left: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(p['original']!, style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey)),
                                  Text(p['price']!, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
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
