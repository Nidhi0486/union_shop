import 'package:flutter/material.dart';

/// Tries a list of image URL candidates until one succeeds. Useful when a copied
/// CDN URL is missing its file extension or has trailing characters.
class NetworkImageWithFallback extends StatefulWidget {
  final String url;
  final BoxFit fit;

  const NetworkImageWithFallback({
    Key? key,
    required this.url,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  State<NetworkImageWithFallback> createState() => _NetworkImageWithFallbackState();
}

class _NetworkImageWithFallbackState extends State<NetworkImageWithFallback> {
  late final List<String> _candidates;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    final sanitized = widget.url.trim().replaceAll(RegExp(r"@+$"), '');
    // Prepare some sensible fallbacks: original, and with common extensions.
    _candidates = [sanitized];
    if (!sanitized.toLowerCase().endsWith('.jpg') && !sanitized.toLowerCase().endsWith('.png') && !sanitized.toLowerCase().contains('?')) {
      _candidates.add('$sanitized.jpg');
      _candidates.add('$sanitized.png');
    }
  }

  void _tryNext() {
    if (_index < _candidates.length - 1) {
      setState(() => _index += 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = _candidates[_index];
    return Image.network(
      current,
      fit: widget.fit,
      width: double.infinity,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) {
        // If we still have candidates left, try the next one.
        WidgetsBinding.instance.addPostFrameCallback((_) => _tryNext());
        // If this is the last candidate show helpful debug UI.
        if (_index == _candidates.length - 1) {
          return Container(
            color: Colors.grey[300],
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.broken_image, size: 48, color: Colors.grey),
                const SizedBox(height: 6),
                Text(
                  current,
                  style: const TextStyle(fontSize: 11),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        }
        // While switching candidates, keep showing a small loader so UI isn't janky.
        return const Center(child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)));
      },
    );
  }
}
