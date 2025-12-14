import 'package:flutter/material.dart';
import 'package:tiziappp2/technicals/widgets/supportwidget.dart';

class Shopequippage extends StatefulWidget {
  const Shopequippage({super.key});

  @override
  State<Shopequippage> createState() => _ShopequippageState();
}

class _ShopequippageState extends State<Shopequippage> {
  // Sample shop products (how users see the shop)
  final List<Map<String, dynamic>> shopProducts = [
    {
      'name': 'Treadmill Pro X1',
      'price': 85000,
      'rating': 4.8,
      'reviews': 24,
      'category': 'Cardio',
    },
    {
      'name': 'Power Rack Elite',
      'price': 45000,
      'rating': 4.9,
      'reviews': 18,
      'category': 'Strength',
    },
    {
      'name': 'Dumbbells Set',
      'price': 35000,
      'rating': 4.7,
      'reviews': 32,
      'category': 'Strength',
    },
    {
      'name': 'Exercise Bike S200',
      'price': 28000,
      'rating': 4.6,
      'reviews': 15,
      'category': 'Cardio',
    },
    {
      'name': 'Rowing Machine R500',
      'price': 55000,
      'rating': 4.8,
      'reviews': 12,
      'category': 'Cardio',
    },
    {
      'name': 'Bench Press Station',
      'price': 32000,
      'rating': 4.7,
      'reviews': 20,
      'category': 'Strength',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shop Preview",
          style: AppWidget.boldTextFieledStyle(),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Shop Preview'),
                  content: const Text(
                    'This is how your shop appears to customers browsing your equipment.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Got it'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Shop header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black,
                      child: const Icon(Icons.fitness_center, color: Colors.white, size: 30),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'PowerPro Fitness Equipment',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star, size: 16, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text('4.8 (120 reviews)', style: TextStyle(color: Colors.grey[600])),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Products grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemCount: shopProducts.length,
              itemBuilder: (context, index) {
                final product = shopProducts[index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product image placeholder
                      Expanded(
                        flex: 3,
                        child: Container(
                          color: Colors.grey[300],
                          child: Center(
                            child: Icon(
                              product['category'] == 'Cardio'
                                  ? Icons.directions_run
                                  : Icons.fitness_center,
                              size: 50,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                      
                      // Product details
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  const Icon(Icons.star, size: 14, color: Colors.amber),
                                  const SizedBox(width: 2),
                                  Text(
                                    '${product['rating']} (${product['reviews']})',
                                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Ksh ${product['price']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}