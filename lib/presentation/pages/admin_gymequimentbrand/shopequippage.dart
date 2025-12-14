import 'package:flutter/material.dart';
import 'package:tiziappp2/technicals/widgets/supportwidget.dart';

class Shopequippage extends StatefulWidget {
  const Shopequippage({super.key});

  @override
  State<Shopequippage> createState() => _ShopequippageState();
}

class _ShopequippageState extends State<Shopequippage> {
  // Hierarchical shop products
  final Map<String, dynamic> shopProducts = {
    'Free Weights': {
      'Kettlebells': [
        {'name': '4kg Kettlebell', 'price': 1500, 'rating': 4.8, 'reviews': 12},
        {'name': '8kg Kettlebell', 'price': 3000, 'rating': 4.9, 'reviews': 15},
        {'name': '12kg Kettlebell', 'price': 4500, 'rating': 4.7, 'reviews': 8},
      ],
      'Dumbbells': {
        'Fixed Weights': [
          {'name': '4kg Dumbbell', 'price': 1200, 'rating': 4.6, 'reviews': 20},
          {'name': '6kg Dumbbell', 'price': 1800, 'rating': 4.8, 'reviews': 18},
          {'name': '8kg Dumbbell', 'price': 2400, 'rating': 4.9, 'reviews': 25},
          {'name': '10kg Dumbbell', 'price': 3000, 'rating': 4.7, 'reviews': 14},
          {'name': '12kg Dumbbell', 'price': 3600, 'rating': 4.8, 'reviews': 10},
          {'name': '14kg Dumbbell', 'price': 4200, 'rating': 4.9, 'reviews': 8},
          {'name': '16kg Dumbbell', 'price': 4800, 'rating': 4.7, 'reviews': 6},
          {'name': '18kg Dumbbell', 'price': 5400, 'rating': 4.8, 'reviews': 5},
          {'name': '20kg Dumbbell', 'price': 6000, 'rating': 4.9, 'reviews': 4},
        ],
        'Adjustable Weights': {
          'Free Bars': [
            {'name': 'Standard Dumbbell Bar', 'price': 1500, 'rating': 4.5, 'reviews': 30},
            {'name': 'Olympic Dumbbell Handle', 'price': 3500, 'rating': 4.8, 'reviews': 10},
          ],
          'Weights': [
            {'name': '1kg Plate', 'price': 300, 'rating': 4.7, 'reviews': 50},
            {'name': '2kg Plate', 'price': 600, 'rating': 4.8, 'reviews': 40},
            {'name': '3kg Plate', 'price': 900, 'rating': 4.6, 'reviews': 30},
            {'name': '4kg Plate', 'price': 1200, 'rating': 4.7, 'reviews': 25},
            {'name': '5kg Plate', 'price': 1500, 'rating': 4.8, 'reviews': 20},
            {'name': '10kg Plate', 'price': 3000, 'rating': 4.9, 'reviews': 15},
            {'name': '15kg Plate', 'price': 4500, 'rating': 4.8, 'reviews': 10},
            {'name': '20kg Plate', 'price': 6000, 'rating': 4.9, 'reviews': 5},
          ]
        }
      },
      'Barbells': {
        'Bars': [
          {'name': 'EZ Bar', 'price': 4500, 'rating': 4.7, 'reviews': 10},
          {'name': 'Olympic Bar (20kg)', 'price': 15000, 'rating': 4.9, 'reviews': 5},
          {'name': 'Standard Bar', 'price': 3500, 'rating': 4.6, 'reviews': 15},
          {'name': 'Trap Bar', 'price': 8000, 'rating': 4.8, 'reviews': 3},
        ],
        'Weights': [
          {'name': '2.5kg Olympic Plate', 'price': 1000, 'rating': 4.8, 'reviews': 40},
          {'name': '5kg Olympic Plate', 'price': 2000, 'rating': 4.9, 'reviews': 30},
          {'name': '10kg Olympic Plate', 'price': 4000, 'rating': 4.7, 'reviews': 20},
          {'name': '15kg Olympic Plate', 'price': 6000, 'rating': 4.8, 'reviews': 15},
          {'name': '20kg Olympic Plate', 'price': 8000, 'rating': 4.9, 'reviews': 10},
          {'name': '25kg Olympic Plate', 'price': 10000, 'rating': 4.8, 'reviews': 5},
        ]
      }
    },
    'Machines': {
      'Arms': [
        {'name': 'Tricep Pull Down Machine', 'price': 85000, 'rating': 4.8, 'reviews': 2},
        {'name': 'Preacher Curl Set', 'price': 45000, 'rating': 4.7, 'reviews': 3},
        {'name': 'Bicep Curl Machine', 'price': 75000, 'rating': 4.9, 'reviews': 2},
      ],
      'Quads': [
        {'name': 'Squat Rack', 'price': 65000, 'rating': 4.9, 'reviews': 4},
        {'name': 'Leg Extension Machine', 'price': 95000, 'rating': 4.8, 'reviews': 2},
        {'name': 'Leg Press Machine', 'price': 120000, 'rating': 4.9, 'reviews': 1},
        {'name': 'Hack Squat Machine', 'price': 110000, 'rating': 4.8, 'reviews': 1},
      ],
      'Hamstrings': [
        {'name': 'Lying Hamstring Curl', 'price': 90000, 'rating': 4.7, 'reviews': 2},
        {'name': 'Seated Leg Curl', 'price': 95000, 'rating': 4.8, 'reviews': 2},
      ],
      'Back': [
        {'name': 'Lat Pull Down Machine', 'price': 85000, 'rating': 4.9, 'reviews': 3},
        {'name': 'Seated Row Machine', 'price': 80000, 'rating': 4.8, 'reviews': 2},
        {'name': 'T-Bar Row', 'price': 45000, 'rating': 4.7, 'reviews': 3},
      ],
      'Shoulders': [
        {'name': 'Shoulder Press Machine', 'price': 90000, 'rating': 4.8, 'reviews': 2},
        {'name': 'Lateral Raise Machine', 'price': 85000, 'rating': 4.9, 'reviews': 1},
      ],
      'Abs': [
        {'name': 'Ab Crunch Machine', 'price': 70000, 'rating': 4.7, 'reviews': 2},
        {'name': 'Decline Bench', 'price': 25000, 'rating': 4.6, 'reviews': 5},
      ],
      'Chest': [
        {'name': 'Chest Press Machine', 'price': 95000, 'rating': 4.8, 'reviews': 2},
        {'name': 'Pec Fly Machine', 'price': 85000, 'rating': 4.9, 'reviews': 2},
      ]
    },
    'Cardio': {
      'Treadmills': [
        {'name': 'Commercial Treadmill T1', 'price': 150000, 'rating': 4.9, 'reviews': 5},
        {'name': 'Home Treadmill T2', 'price': 85000, 'rating': 4.7, 'reviews': 10},
      ],
      'Bikes': [
        {'name': 'Spin Bike Pro', 'price': 45000, 'rating': 4.8, 'reviews': 8},
        {'name': 'Recumbent Bike', 'price': 55000, 'rating': 4.7, 'reviews': 4},
      ],
      'Ellipticals': [
        {'name': 'Elliptical Trainer E1', 'price': 95000, 'rating': 4.8, 'reviews': 3},
      ],
      'Rowers': [
        {'name': 'Air Rower R1', 'price': 75000, 'rating': 4.9, 'reviews': 5},
      ]
    }
  };

  // Recursive function to build the category tree for shop
  Widget _buildShopCategoryTree(Map<String, dynamic> data, [String prefix = '']) {
    return Column(
      children: data.entries.map((entry) {
        if (entry.value is Map<String, dynamic>) {
          // It's a category or subcategory
          return ExpansionTile(
            title: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold)),
            children: [_buildShopCategoryTree(entry.value, '$prefix${entry.key} > ')],
          );
        } else if (entry.value is List) {
          // It's a list of items (leaf node) - display as grid
          return ExpansionTile(
            title: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w600)),
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.75,
                ),
                itemCount: (entry.value as List).length,
                itemBuilder: (context, index) {
                  final product = (entry.value as List)[index];
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
                                Icons.fitness_center,
                                size: 40,
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
                                    fontSize: 12,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Icon(Icons.star, size: 12, color: Colors.amber),
                                    const SizedBox(width: 2),
                                    Text(
                                      '${product['rating']} (${product['reviews']})',
                                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Ksh ${product['price']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
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
            ],
          );
        }
        return const SizedBox.shrink();
      }).toList(),
    );
  }

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
          
          // Products list with hierarchy
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildShopCategoryTree(shopProducts),
              ),
            ),
          ),
        ],
      ),
    );
  }
}