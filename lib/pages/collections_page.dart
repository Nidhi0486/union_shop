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
                      itemCount: categories.length,
                      itemBuilder: (context, idx) {
                        final c = categories[idx];
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/collection', arguments: c['name']),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  // For Accessories show a small collage of accessory thumbnails for clarity
                                  if (c['name'] == 'Accessories')
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: GridView.count(
                                        physics: const NeverScrollableScrollPhysics(),
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 6,
                                        mainAxisSpacing: 6,
                                        children: [
                                          Image.asset('assets/images/PortsmouthCityBookmark.png', fit: BoxFit.cover, errorBuilder: (ctx, e, st) => Container(color: Colors.grey[200])),
                                          Image.asset('assets/images/PortsmouthCityMagnet.png', fit: BoxFit.cover, errorBuilder: (ctx, e, st) => Container(color: Colors.grey[200])),
                                          Image.asset('assets/images/PortsmouthCityPostcard.png', fit: BoxFit.cover, errorBuilder: (ctx, e, st) => Container(color: Colors.grey[200])),
                                          Image.asset('assets/images/Notebook.png', fit: BoxFit.cover, errorBuilder: (ctx, e, st) => Container(color: Colors.grey[200])),
                                        ],
                                      ),
                                    )
                                  else
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
