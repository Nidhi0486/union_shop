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
      // accessories - curated list: PortsmouthCity souvenirs + notebooks/pads
      imageList = [
        'assets/images/PortsmouthCityBookmark.png',
        'assets/images/PortsmouthCityKeyring.jpg',
        'assets/images/PortsmouthCityMagnet.png',
        'assets/images/PortsmouthCityPostcard.png',
        'assets/images/Notebook.png',
        'assets/images/Notepad.png',
      ];
    }

    final products = List.generate(imageList.length, (i) {
      final index = i + 1;
      return {
        'title': '$name $index',
        'price': '£${25 + i * 5}.00',
        'image': imageList[i],
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
                          MaterialPageRoute(builder: (_) => ProductDetailPage(product: Map<String, dynamic>.from(p))),
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
