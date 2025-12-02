import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import '../widgets/product_card.dart';

import 'product_detail_page.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)!.settings.arguments as String? ?? 'Hoodies';
    final products = List.generate(6, (i) => {
          'title': '$name Hoodie ${i + 1}',
          'price': '£${25 + i * 5}.00',
          'image': 'https://via.placeholder.com/400x400.png'
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
                  Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  // visual filters (non-functional)
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          value: 'All',
                          items: const [DropdownMenuItem(value: 'All', child: Text('All Sizes'))],
                          onChanged: (_) {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButton<String>(
                          value: 'Any',
                          items: const [DropdownMenuItem(value: 'Any', child: Text('Any Colour'))],
                          onChanged: (_) {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: products.map((p) {
                      return ProductCardSmall(
                        title: p['title']!,
                        price: p['price']!,
                        imageUrl: p['image']!,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ProductDetailPage(product: Map<String, String>.from(p))),
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
