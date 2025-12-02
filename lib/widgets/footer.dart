import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 20,
            runSpacing: 8,
            children: [
              GestureDetector(
                onTap: () {},
                child: const Text('Contact us', style: TextStyle(color: Colors.grey)),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text('FAQ', style: TextStyle(color: Colors.grey)),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // fake social links using built-in icons
                  Icon(Icons.facebook, size: 18, color: Colors.grey),
                  SizedBox(width: 8),
                  Icon(Icons.share, size: 18, color: Colors.grey),
                  SizedBox(width: 8),
                  Icon(Icons.camera_alt, size: 18, color: Colors.grey),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('© 2024 Union Shop', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
