import 'package:flutter/material.dart';

/// Simple local placeholder that looks like an image.
class LocalPlaceholderImage extends StatelessWidget {
  final String label;
  final Color? color;

  const LocalPlaceholderImage({Key? key, required this.label, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Colors.grey.shade300,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
