import 'package:flutter/material.dart';
// Firebase removed for local development; add back when configured.
import 'package:provider/provider.dart';

import 'models/cart.dart';
import 'pages/cart_page.dart';
import 'package:union_shop/pages/about_page.dart';
import 'package:union_shop/pages/auth_page.dart';
import 'package:union_shop/pages/collection_page.dart';
import 'package:union_shop/pages/collections_page.dart';
import 'package:union_shop/pages/sales_page.dart';
import 'package:union_shop/pages/login_page.dart';
import 'package:union_shop/pages/signup_page.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/widgets/product_card.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Run without Firebase initialization (keeps app runnable for local dev).
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartModel(),
      child: MaterialApp(
        title: 'Union Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/product': (context) => const ProductPage(),
          '/collections': (context) => const CollectionsPage(),
          '/collection': (context) => const CollectionPage(),
          '/cart': (context) => const CartPage(),
          '/about': (context) => const AboutPage(),
          '/sales': (context) => const SalesPage(),
          '/auth': (context) => const AuthPage(),
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignupPage(),
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const products = [
      {
        'title': 'Placeholder Product 1',
        'price': '£10.00',
        'image': 'https://via.placeholder.com/400x400'
      },
      {
        'title': 'Placeholder Product 2',
        'price': '£15.00',
        'image': 'https://via.placeholder.com/400x400'
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeader(),
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('https://via.placeholder.com/1200x600'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(color: Colors.black26),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/collections'),
                      child: const Text('Browse products'),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text('PRODUCTS', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: products.map((p) {
                        return ProductCardSmall(
                          title: p['title']!,
                          price: p['price']!,
                          imageUrl: p['image']!,
                          onTap: () => Navigator.pushNamed(context, '/product'),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}

