import 'package:flutter/material.dart';
import 'dart:async';
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
import 'package:union_shop/pages/product_detail_page.dart';
import 'package:union_shop/pages/account_page.dart';
import 'package:union_shop/pages/preview_images_page.dart';
import 'package:union_shop/pages/personalization_page.dart';

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
          // Aggressively disable default ink/focus/highlight overlays used on web
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          // Remove ripple/focus visual for Material widgets
          splashFactory: NoSplash.splashFactory,
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              splashFactory: NoSplash.splashFactory,
            ),
          ),
          iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              splashFactory: NoSplash.splashFactory,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              splashFactory: NoSplash.splashFactory,
            ),
          ),
          dividerColor: Colors.grey.shade300,
          dropdownMenuTheme: DropdownMenuThemeData(menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.white))),
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
          '/account': (context) => const AccountPage(),
          '/preview': (context) => const PreviewImagesPage(),
          '/personalize': (context) => const PersonalizationPage(),
        },
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  final List<Map<String, String>> promos = [
    {
      'title': '20% OFF SITEWIDE',
      'subtitle': 'Limited time — use code: UNION20',
    },
    {
      'title': 'Free delivery over £50',
      'subtitle': 'Get your favourites delivered for free',
    },
    {
      'title': 'New arrivals: Autumn drop',
      'subtitle': 'Fresh styles, limited quantities',
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      _currentPage = (_currentPage + 1) % promos.length;
      _pageController.animateToPage(_currentPage, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'title': 'Purple Hoodie',
        'price': '£30.00',
        'description': 'Purple Hoodie: A cozy purple hoodie that adds a bold pop of color to casual outfits.',
        'images': ['assets/images/hoodie1.jpg', 'assets/images/hoodie2.png']
      },
      {
        'title': 'Pink Hoodie',
        'price': '£28.00',
        'description': 'Pink Hoodie: A soft pink hoodie designed for everyday comfort with a clean, modern look.',
        'images': ['assets/images/hoodie2.png', 'assets/images/hoodie3.png']
      },
      {
        'title': 'T-Shirt',
        'price': '£15.00',
        'description': 'T-Shirt: A lightweight, breathable T-shirt made for easy all-day wear.',
        'images': ['assets/images/tshirt.png', 'assets/images/tshirt1.webp']
      },
      {
        'title': 'Notebook Set',
        'price': '£12.00',
        'description': 'Notebook Set: Eco-friendly notebooks with matching pens, perfect for jotting ideas or daily notes.',
        'images': ['assets/images/Notebook.png']
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeader(),
            // Promo carousel hero
            SizedBox(
              height: 360,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: promos.length,
                    itemBuilder: (context, i) {
                      final promo = promos[i];
                      return Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://via.placeholder.com/1600x600'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          color: const Color.fromRGBO(0, 0, 0, 0.35),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(promo['title']!, style: const TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                Text(promo['subtitle']!, style: const TextStyle(color: Colors.white70, fontSize: 16)),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: () => Navigator.pushNamed(context, '/collections'),
                                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4d2963)),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                    child: Text('Shop now', style: TextStyle(fontSize: 16)),
                                  ),
                                ),
                                // Personalise button removed from the hero — accessible from the header nav
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    onPageChanged: (idx) => setState(() => _currentPage = idx),
                  ),
                  // Dots indicator
                  Positioned(
                    bottom: 18,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(promos.length, (i) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == i ? 12 : 8,
                          height: _currentPage == i ? 12 : 8,
                          decoration: BoxDecoration(color: _currentPage == i ? Colors.white : Colors.white54, shape: BoxShape.circle),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Featured products', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),

                    LayoutBuilder(builder: (context, constraints) {
                        int cols = 1;
                        if (constraints.maxWidth > 1100) {
                          cols = 3;
                        } else if (constraints.maxWidth > 700) {
                          cols = 2;
                        }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: cols,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          // Give more vertical space so image + text don't overflow
                          childAspectRatio: 0.7,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, i) {
                          final p = products[i];
                          // prefer images list first image if present
                          String imageSrc;
                          final imgs = p['images'];
                          if (imgs is List && imgs.isNotEmpty) {
                            imageSrc = imgs[0] as String;
                          } else {
                            imageSrc = p['image'] as String;
                          }
                          return ProductCardSmall(
                            title: p['title']! as String,
                            price: p['price']! as String,
                            description: p['description'] as String?,
                            imageUrl: imageSrc,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailPage(product: Map<String, dynamic>.from(p)),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }),
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

