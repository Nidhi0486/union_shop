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
    const accent = Color(0xFF4d2963);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Logo + title (disable focus/ink on the logo tappable area)
          FocusableActionDetector(
            enabled: false,
            mouseCursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _go(context, '/'),
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  // Try to show the local asset first; if it fails (for example during a hot reload
                  // or if the asset wasn't packaged), fall back to the network image.
                  Image.asset(
                    'assets/images/logo.png',
                    height: 48,
                    width: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                        height: 48,
                        width: 48,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, st) => Container(
                          color: Colors.grey[300],
                          width: 48,
                          height: 48,
                          child: const Icon(Icons.image_not_supported),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  const Text('Union Shop', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: accent)),
                ],
              ),
            ),
          ),

          // Center navigation
          Expanded(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(onPressed: () => _go(context, '/'), child: const Text('Home')),
                  const SizedBox(width: 8),
                  TextButton(onPressed: () => _go(context, '/collections'), child: const Text('Collections')),
                  const SizedBox(width: 8),
                  TextButton(onPressed: () => _go(context, '/sales'), child: const Text('Sales')),
                  const SizedBox(width: 8),
                  TextButton(onPressed: () => _go(context, '/personalize'), child: const Text('Personalize')),
                  const SizedBox(width: 8),
                  // Preview button removed
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutPage()));
                    },
                    child: const Text('About'),
                  ),
                ],
              ),
            ),
          ),

          // Search + icons
          SizedBox(
            width: 240,
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
              child: Row(
                children: [
                  const Icon(Icons.search, size: 20, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(border: InputBorder.none, hintText: 'Search products'),
                      onSubmitted: (q) {
                        // naive search navigation: open collections and print query
                        // ignore: avoid_print
                        print('Search: $q');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
