import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            AppHeader(),
            const SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to Union Shop',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF4d2963)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'We sell merch, apparel, and accessories celebrating student life. Our small shop focuses on quality designs, comfortable fits, and fast shipping.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Browse our collections, find limited edition drops, and support campus groups. If you have questions, use the contact form on the footer to reach out.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
