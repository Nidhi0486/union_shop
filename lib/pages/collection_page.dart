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
    // Pick image lists based on collection name so each collection shows correct items
    final lower = name.toLowerCase();
    List<String> imageList;
    if (lower.contains('hoodie')) {
      // Use the exact hoodie asset filenames present in assets/images/
      imageList = [
        'assets/images/hoodie1.jpg',
        'assets/images/hoodie2.png',
        'assets/images/hoodie3.png',
        'assets/images/Ivory_Hoodie4.png',
        'assets/images/RainbowHoodie5.png',
        'assets/images/SageHoodie6.png',
      ];
    } else if (lower.contains('shirt') || lower.contains('t-shirt') || lower.contains('tshirt')) {
      imageList = [
        'assets/images/tshirt.png',
        'assets/images/tshirt1.webp',
        'assets/images/tshirt.png',
      ];
    } else {
      // accessories - show only the two primary items (avoid empty/missing images)
      // Use exact filenames present in assets/images/
      imageList = [
        'assets/images/PortsmouthCityKeyring.jpg',
        'assets/images/Notebook.png',
      ];
    }

    // Build products. For accessories we prefer explicit titles/prices to avoid generic placeholders.
    late final List<Map<String, String>> products;
    if (lower.contains('accessor') || lower.contains('accessories')) {
      products = [
        {
          'title': 'Portsmouth Keyring',
          'price': '£6.00',
          'image': 'assets/images/PortsmouthCityKeyring.jpg',
          'description': 'A stylish keyring featuring the iconic Portsmouth city emblem, perfect for showing off your city pride.',
        },
        {
          'title': 'Notebook Set',
          'price': '£12.00',
          'image': 'assets/images/Notebook.png',
          'description': 'A set of two A5 notebooks featuring iconic Portsmouth landmarks on the covers.',
        },
        
      ];
    } else {
      products = List.generate(imageList.length, (i) {
        final index = i + 1;
        return {
          'title': '$name $index',
          'price': '£${25 + i * 5}.00',
          'image': imageList[i],
        };
      });
    }

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
                  LayoutBuilder(builder: (ctx, cons) {
                    final cols = cons.maxWidth > 600 ? 3 : 1;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: cols,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, idx) {
                        final p = products[idx];
                        return ProductCardSmall(
                          title: p['title']!,
                          price: p['price']!,
                          imageUrl: p['image']!,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ProductDetailPage(product: Map<String, dynamic>.from(p))),
                          ),
                        );
                      },
                    );
                  }),
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
