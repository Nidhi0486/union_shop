import 'package:flutter/material.dart';
import 'network_image_fallback.dart';

class ProductCardSmall extends StatelessWidget {
  final String title;
  final String price;
  final String? description;
  final String imageUrl;
  final VoidCallback? onTap;

  const ProductCardSmall({
    super.key,
    required this.title,
    required this.price,
    this.description,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      enabled: false,
      mouseCursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          AspectRatio(
            aspectRatio: 1,
              child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Builder(builder: (context) {
                if (imageUrl.startsWith('assets/')) {
                  return Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, error, stackTrace) {
                      // show a neutral placeholder if the asset is missing or fails to decode
                      return Container(
                        color: Colors.grey[200],
                        child: const Center(child: Icon(Icons.broken_image, size: 40, color: Colors.grey)),
                      );
                    },
                  );
                }
                if (imageUrl.startsWith('local:')) {
                  final key = imageUrl.split(':').last;
                  final assetPath = 'assets/images/${key == 'tshirts' ? 'tshirt.png' : '$key.png'}';
                  return Image.asset(assetPath, fit: BoxFit.cover);
                }
                return NetworkImageWithFallback(url: imageUrl, fit: BoxFit.cover);
              }),
            ),
          ),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.black), maxLines: 2),
          if (description != null) ...[
            const SizedBox(height: 4),
            Text(description!, style: const TextStyle(fontSize: 12, color: Colors.grey), maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
          const SizedBox(height: 4),
          Text(price, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
