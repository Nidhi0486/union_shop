import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import '../models/cart.dart';
import '../models/product.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  // common filename aliases mapped to actual packaged assets
  static const Map<String, String> _aliasMap = {
    // alias map intentionally left minimal; removed nike/cap aliases per request
  };

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'title': 'Neutral Collection - Sale',
        'original': '£35.00',
        'price': '£21.00',
        'Discription': 'Stylish neutral collection item on sale.',
        'image': 'assets/images/Neutral sale.png'
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
                  FutureBuilder<List<String>>(
                    future: _loadAssetKeys(),
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final keys = snap.data ?? <String>[];
                      return LayoutBuilder(builder: (context, constraints) {
                        final cols = constraints.maxWidth > 900 ? 3 : (constraints.maxWidth > 600 ? 2 : 1);
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: cols, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.7),
                          itemCount: products.length,
                          itemBuilder: (context, idx) {
                            final p = Map<String, String>.from(products[idx]);
                            final resolved = _resolveImagePath(p['image']!, keys);
                            return GestureDetector(
                              onTap: () => Navigator.pushNamed(context, '/product'),
                              child: FocusableActionDetector(
                                enabled: false,
                                mouseCursor: SystemMouseCursors.basic,
                                child: Stack(
                                  children: [
                                    // show the image (resolved) so assets are used if present
                                    Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white, border: Border.all(color: Colors.grey.shade200)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 1,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: (keys.contains(resolved))
                                                  ? Image.asset(
                                                      resolved,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (c, e, st) => Container(
                                                        color: Colors.grey[200],
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              const Icon(Icons.broken_image, size: 40),
                                                              const SizedBox(height: 8),
                                                              Text('missing asset:\n$resolved', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Image.network(
                                                      Uri.encodeFull(resolved),
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (c, e, st) => Container(
                                                        color: Colors.grey[200],
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              const Icon(Icons.broken_image, size: 40),
                                                              const SizedBox(height: 8),
                                                              Text('missing network asset:\n$resolved', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text(p['title']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                          ),
                                          const SizedBox(height: 6),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Builder(builder: (ctx) {
                                              final found = keys.contains(resolved);
                                              return Row(
                                                children: [
                                                  Icon(found ? Icons.check_circle_outline : Icons.error_outline, size: 14, color: found ? Colors.green : Colors.red),
                                                  const SizedBox(width: 6),
                                                  Expanded(child: Text(resolved, style: TextStyle(fontSize: 11, color: Colors.grey[700]), overflow: TextOverflow.ellipsis)),
                                                ],
                                              );
                                            }),
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
                                    // Add to cart button
                                    Positioned(
                                      right: 8,
                                      bottom: 8,
                                      child: Builder(builder: (btnCtx) {
                                        return ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4d2963)),
                                          onPressed: () {
                                            // construct a Product instance from the sale map
                                            final priceStr = p['price'] ?? '£0.00';
                                            final priceVal = double.tryParse(priceStr.replaceAll(RegExp(r'[^0-9\.]'), '')) ?? 0.0;
                                            final prod = Product(
                                              id: p['title'] ?? DateTime.now().toIso8601String(),
                                              title: p['title'] ?? 'Sale item',
                                              description: p['Discription'] ?? '',
                                              price: priceVal,
                                              imageUrl: resolved,
                                            );
                                            context.read<CartModel>().add(prod, qty: 1);
                                            ScaffoldMessenger.of(btnCtx).showSnackBar(const SnackBar(content: Text('Added to cart')));
                                          },
                                          icon: const Icon(Icons.add_shopping_cart, size: 16),
                                          label: const Text('Add'),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      });
                    },
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

  Future<List<String>> _loadAssetKeys() async {
    try {
      final manifest = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> map = json.decode(manifest) as Map<String, dynamic>;
      return map.keys.where((k) => k.startsWith('assets/images/')).toList();
    } catch (_) {
      return <String>[];
    }
  }

  String _resolveImagePath(String requested, List<String> available) {
    // check alias map for common variants
    final key = requested.split('/').last.toLowerCase();
    if (_aliasMap.containsKey(key)) {
      final mapped = _aliasMap[key]!;
      if (available.contains(mapped)) return mapped;
      // if mapped not packaged, still try mapped path (it will show errorBuilder if missing)
      return mapped;
    }

    // direct match
    if (available.contains(requested)) return requested;

    // try common variations: lowercased, replace spaces with underscores, hyphens, remove spaces
    final variants = <String>{
      requested.toLowerCase(),
      requested.replaceAll(' ', '_'),
      requested.replaceAll(' ', '-'),
      requested.replaceAll(' ', ''),
      requested.toLowerCase().replaceAll(' ', '_'),
      requested.toLowerCase().replaceAll(' ', '-'),
    };

    for (final v in variants) {
      final candidate = 'assets/images/${v.split('/').last}';
      if (available.contains(candidate)) return candidate;
    }

    // fallback: try to find any file that contains the basename (case-insensitive)
    final base = requested.split('/').last.split('.').first.toLowerCase();
    for (final a in available) {
      final name = a.split('/').last.toLowerCase();
      if (name.contains(base)) return a;
    }

    // final fallback: keep the original requested path; Image.asset will show errorBuilder
    return requested;
  }
}
