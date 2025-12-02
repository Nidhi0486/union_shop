import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import '../widgets/network_image_fallback.dart';
import '../widgets/local_placeholder_image.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Hoodies', 'image': 'local:hoodies'},
      {'name': 'T-shirts', 'image': 'local:tshirts'},
      {'name': 'Accessories', 'image': 'local:accessories'},
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
                                // Show a simple local placeholder (drawn in Flutter)
                                if (c['image']!.startsWith('assets/'))
                                  Image.asset(c['image']!, fit: BoxFit.cover)
                                else if (c['image']!.startsWith('local:'))
                                  LocalPlaceholderImage(label: c['name']!, color: Colors.purple.shade400)
                                else
                                  NetworkImageWithFallback(url: c['image']!),
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
