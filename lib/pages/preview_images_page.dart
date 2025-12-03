import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';

class PreviewImagesPage extends StatelessWidget {
  const PreviewImagesPage({Key? key}) : super(key: key);

  Future<List<String>> _loadImageAssets(BuildContext context) async {
    String manifestContent;
    try {
      manifestContent = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    } catch (_) {
      // fallback to rootBundle if DefaultAssetBundle isn't available in this context
      manifestContent = await rootBundle.loadString('AssetManifest.json');
    }
    final Map<String, dynamic> manifestMap = json.decode(manifestContent) as Map<String, dynamic>;
    final images = manifestMap.keys.where((String k) => k.startsWith('assets/images/') && (k.endsWith('.png') || k.endsWith('.jpg') || k.endsWith('.jpeg') || k.endsWith('.webp'))).toList();
    images.sort();
    return images;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppHeader(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Preview: Packaged Images', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                FutureBuilder<List<String>>(
                  future: _loadImageAssets(context),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final images = snap.data ?? [];
                    if (images.isEmpty) {
                      return const Text('No packaged images found under assets/images/');
                    }
                    return LayoutBuilder(builder: (ctx, constraints) {
                      final cross = constraints.maxWidth > 1000 ? 5 : (constraints.maxWidth > 700 ? 4 : 2);
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: cross, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1),
                        itemCount: images.length,
                        itemBuilder: (context, i) {
                          final asset = images[i];
                          final name = asset.split('/').last;
                          return Column(
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
                                  child: Image.asset(asset, fit: BoxFit.cover, errorBuilder: (c, e, st) => const Center(child: Icon(Icons.broken_image))),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(name, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis),
                            ],
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
    );
  }
}
