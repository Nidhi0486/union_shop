import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../pages/about_page.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  void _go(BuildContext context, String route) {
    if (route == '/') {
      Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
    } else {
      Navigator.pushNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _go(context, '/'),
                    child: Row(
                      children: [
                        Image.network(
                          'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                          height: 36,
                          width: 36,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, st) => Container(
                            color: Colors.grey[300],
                            width: 36,
                            height: 36,
                            child: const Icon(Icons.image_not_supported),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('Union Shop', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4d2963))),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          TextButton(onPressed: () => _go(context, '/'), child: const Text('Home')),
                          TextButton(onPressed: () => _go(context, '/collections'), child: const Text('Collections')),
                          TextButton(onPressed: () => _go(context, '/sales'), child: const Text('Sales')),
                          TextButton(
                            onPressed: () {
                              // push directly to AboutPage to avoid named-route mismatches on web
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutPage()));
                              // debug
                              // ignore: avoid_print
                              print('Navigated to AboutPage');
                            },
                            child: const Text('About'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.person_outline, color: Colors.grey), onPressed: () => _go(context, '/auth')),
                  Consumer<CartModel>(builder: (context, cart, _) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.shopping_bag_outlined, color: Colors.grey),
                          onPressed: () => _go(context, '/cart'),
                        ),
                        if (cart.items.isNotEmpty)
                          Positioned(
                            right: 6,
                            top: 6,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)),
                              child: Text('${cart.items.length}', style: const TextStyle(color: Colors.white, fontSize: 12)),
                            ),
                          ),
                      ],
                    );
                  }),
                ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
