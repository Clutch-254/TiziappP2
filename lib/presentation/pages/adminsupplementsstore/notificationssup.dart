import 'package:flutter/material.dart';

class Notificationssup extends StatefulWidget {
  const Notificationssup({super.key});

  @override
  State<Notificationssup> createState() => _NotificationssupState();
}

class _NotificationssupState extends State<Notificationssup> {
  // Most bought products
  final List<Map<String, dynamic>> mostBoughtProducts = [
    {
      'name': 'Ultimate Whey Protein',
      'unitsSold': 245,
      'revenue': 857500.0,
      'category': 'Protein',
    },
    {
      'name': 'Pre-Workout Extreme',
      'unitsSold': 198,
      'revenue': 297000.0,
      'category': 'Performance',
    },
    {
      'name': 'Multivitamin Elite',
      'unitsSold': 167,
      'revenue': 434200.0,
      'category': 'Wellness',
    },
  ];

  // Least bought products
  final List<Map<String, dynamic>> leastBoughtProducts = [
    {
      'name': 'Specialized Recovery Formula',
      'unitsSold': 12,
      'revenue': 36000.0,
      'category': 'Recovery',
    },
    {
      'name': 'Advanced Amino Blend',
      'unitsSold': 18,
      'revenue': 45000.0,
      'category': 'Performance',
    },
    {
      'name': 'Sleep Support Complex',
      'unitsSold': 23,
      'revenue': 57500.0,
      'category': 'Wellness',
    },
  ];

  // Best reviewed products
  final List<Map<String, dynamic>> bestReviewedProducts = [
    {
      'name': 'Ultimate Whey Protein',
      'rating': 4.8,
      'reviews': 156,
      'category': 'Protein',
    },
    {
      'name': 'Joint Support Complex',
      'rating': 4.7,
      'reviews': 89,
      'category': 'Wellness',
    },
    {
      'name': 'Pre-Workout Extreme',
      'rating': 4.6,
      'reviews': 134,
      'category': 'Performance',
    },
  ];

  // Least good reviewed products
  final List<Map<String, dynamic>> leastReviewedProducts = [
    {
      'name': 'Budget Protein Mix',
      'rating': 3.2,
      'reviews': 45,
      'category': 'Protein',
    },
    {
      'name': 'Basic Energy Booster',
      'rating': 3.5,
      'reviews': 28,
      'category': 'Performance',
    },
    {
      'name': 'Standard Multivitamin',
      'rating': 3.7,
      'reviews': 52,
      'category': 'Wellness',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color.fromARGB(255, 47, 47, 49);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics & Stats'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overview Stats
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Overview',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildOverviewCard('Total Sales', 'KSh 2.4M', Colors.green, Icons.trending_up),
                        _buildOverviewCard('Products', '127', primaryColor, Icons.inventory),
                        _buildOverviewCard('Avg Rating', '4.3', Colors.orange, Icons.star),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Most Bought Products
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.trending_up, color: Colors.green),
                        const SizedBox(width: 8),
                        const Text(
                          'Most Bought Products',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...mostBoughtProducts.map((product) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.shopping_bag, color: Colors.green),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name'],
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${product['unitsSold']} units sold • KSh ${product['revenue']}',
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Least Bought Products
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.trending_down, color: Colors.red),
                        const SizedBox(width: 8),
                        const Text(
                          'Least Bought Products',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...leastBoughtProducts.map((product) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.red[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.shopping_bag_outlined, color: Colors.red),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name'],
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${product['unitsSold']} units sold • KSh ${product['revenue']}',
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Best Reviewed Products
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        const SizedBox(width: 8),
                        const Text(
                          'Best Reviewed Products',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...bestReviewedProducts.map((product) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.amber[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  product['rating'].toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name'],
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      ...List.generate(5, (index) {
                                        return Icon(
                                          index < product['rating'].floor()
                                              ? Icons.star
                                              : Icons.star_border,
                                          size: 14,
                                          color: Colors.amber,
                                        );
                                      }),
                                      const SizedBox(width: 4),
                                      Text(
                                        '(${product['reviews']} reviews)',
                                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Least Good Reviewed Products
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star_border, color: Colors.grey),
                        const SizedBox(width: 8),
                        const Text(
                          'Products Needing Improvement',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...leastReviewedProducts.map((product) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  product['rating'].toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name'],
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      ...List.generate(5, (index) {
                                        return Icon(
                                          index < product['rating'].floor()
                                              ? Icons.star
                                              : Icons.star_border,
                                          size: 14,
                                          color: Colors.grey,
                                        );
                                      }),
                                      const SizedBox(width: 4),
                                      Text(
                                        '(${product['reviews']} reviews)',
                                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(String label, String value, Color color, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 32),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}