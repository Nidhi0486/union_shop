import 'package:flutter/material.dart';
import 'network_image_fallback.dart';

class ProductCardSmall extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  final VoidCallback? onTap;

  const ProductCardSmall({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: NetworkImageWithFallback(url: imageUrl, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.black), maxLines: 2),
          const SizedBox(height: 4),
          Text(price, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        ],
      ),
    );
  }
}
