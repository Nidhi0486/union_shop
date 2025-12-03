import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF4d2963);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeader(),

            // Hero
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/1600x600?text=Union+Shop+About'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: const Color.fromRGBO(0, 0, 0, 0.45),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('About Union Shop', style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('University merchandise, ethical sourcing, and community support', style: TextStyle(color: Colors.white70, fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),

            // Intro + mission
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Who we are', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  const Text(
                    'Union Shop is the official student shop supporting campus life. We design and sell clothing, accessories, and gifts that celebrate student communities. Our mission is to provide high-quality merch while supporting student groups and sustainable suppliers.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),

                  // Mission & values cards
                  LayoutBuilder(builder: (ctx, constraints) {
                    final isWide = constraints.maxWidth > 800;
                    return Flex(
                      direction: isWide ? Axis.horizontal : Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _InfoCard(title: 'Our Mission', body: 'Design and deliver quality merchandise that students are proud to wear. We partner with student groups and local suppliers.'),
                        SizedBox(height: 12, width: 12),
                        _InfoCard(title: 'Our Values', body: 'Sustainability, fairness, and community — we choose suppliers who align with these values.'),
                        SizedBox(height: 12, width: 12),
                        _InfoCard(title: 'Quality', body: 'We focus on durable fabrics and careful printing/embroidery so items last beyond graduation.'),
                      ],
                    );
                  }),

                  const SizedBox(height: 24),

                  // Store details / contact
                  const Text('Visit & contact', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Opening hours', style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Text('Mon - Fri: 09:00 - 17:00'),
                            Text('Sat: 10:00 - 16:00'),
                            Text('Sun: Closed'),
                            SizedBox(height: 12),
                            Text('Location', style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Text('Student Union Building, High Street, Portsmouth'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Contact', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            const Text('Email: shop@union.example.uk'),
                            const SizedBox(height: 6),
                            const Text('Phone: 01234 567890'),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () => Navigator.pushNamed(context, '/collections'),
                              style: ElevatedButton.styleFrom(backgroundColor: accent),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
                                child: Text('Shop collections', style: TextStyle(fontSize: 16)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Community / support paragraph
                  const Text('Supporting students', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  const Text(
                    'A portion of proceeds from special collections is donated to campus societies and events. If you are a society looking for merch, contact us and we can arrange custom orders.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 40),
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

class _InfoCard extends StatelessWidget {
  final String title;
  final String body;
  const _InfoCard({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 8)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(body, style: const TextStyle(fontSize: 14, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
