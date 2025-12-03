import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import '../widgets/network_image_fallback.dart';
// ...existing imports

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Hoodies', 'image': 'assets/images/hoodie1.jpg'},
      {'name': 'T-shirts', 'image': 'assets/images/tshirt.png'},
      // show a Portsmouth souvenir as the accessories thumbnail
      {'name': 'Accessories', 'image': 'assets/images/PortsmouthCityPostcard.png'},
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('Collections', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: categories.map((c) {
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/collection', arguments: c['name']),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                (() {
                                  final imgPath = c['image']!;
                                  return Image.asset(imgPath, fit: BoxFit.cover, errorBuilder: (ctx, e, st) => NetworkImageWithFallback(url: imgPath));
                                })(),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.black26),
                                  child: Text(c['name']!, style: const TextStyle(color: Colors.white, fontSize: 18)),
                                ),
                              ],
                            ),
                          ),
                          
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
