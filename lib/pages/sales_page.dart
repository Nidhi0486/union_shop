import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'title': 'Nike Pants - Sale',
        'original': '£45.00',
        'price': '£30.00',
        'image': 'assets/images/Nike_Pants_Sale2.png'
      },
      {
        'title': 'Neutral Collection - Sale',
        'original': '£35.00',
        'price': '£21.00',
        'image': 'assets/images/Neutral sale.png'
      },
      {
        'title': 'Cap - Sale',
        'original': '£20.00',
        'price': '£12.00',
        'image': 'assets/images/Cap sales3.png'
      },
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
                  const Text('Sales', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  LayoutBuilder(builder: (context, constraints) {
                    final cols = constraints.maxWidth > 900 ? 3 : (constraints.maxWidth > 600 ? 2 : 1);
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: cols, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.9),
                      itemCount: products.length,
                      itemBuilder: (context, idx) {
                        final p = products[idx];
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/product'),
                          child: Stack(
                            children: [
                              // show the image directly so assets are guaranteed to be used
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white, border: Border.all(color: Colors.grey.shade200)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(p['image']!, fit: BoxFit.cover, errorBuilder: (c, e, st) => Container(color: Colors.grey[200], child: const Center(child: Icon(Icons.broken_image)))),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(p['title']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(height: 4),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                            ],
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
