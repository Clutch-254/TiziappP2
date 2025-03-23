import 'package:flutter/material.dart';

class Adminvirtualfoodstore extends StatefulWidget {
  const Adminvirtualfoodstore({super.key});

  @override
  State<Adminvirtualfoodstore> createState() => _AdminvirtualfoodstoreState();
}

class _AdminvirtualfoodstoreState extends State<Adminvirtualfoodstore> {
  // Sample food store data
  final String storeName = "Healthy Bites Market";
  final String businessType = "Organic Food & Nutrition Store";
  final String description =
      "Established in 2018, Healthy Bites Market is a premium nutrition-focused food store "
      "specializing in organic produce, whole foods, and healthy meal options. We offer a wide "
      "selection of high-quality ingredients for health-conscious individuals, fitness enthusiasts, "
      "and those with specific dietary needs. Our store features locally sourced organic produce, "
      "protein-rich foods, and pre-prepared healthy meals designed by nutritionists "
      "to support various fitness and health goals.";

  // Updated products list without supplements
  final List<Map<String, dynamic>> products = [
    {
      'category': 'Organic Produce',
      'details':
          'Locally sourced fruits and vegetables from certified organic farms',
      'icon': Icons.eco
    },
    {
      'category': 'Protein Foods',
      'details':
          'High-quality lean meats, plant proteins, and protein supplements',
      'icon': Icons.egg_alt
    },
    {
      'category': 'Prepared Meals',
      'details':
          'Nutritionist-designed balanced meals for various dietary requirements',
      'icon': Icons.lunch_dining
    }
  ];

  // New menu items
  final List<Map<String, dynamic>> menuItems = [
    {
      'name': 'Green Power Bowl',
      'description':
          'Organic kale, spinach, avocado, quinoa, grilled chicken, and lemon tahini dressing',
      'type': 'Lunch/Dinner',
      'icon': Icons.restaurant_menu
    },
    {
      'name': 'Protein Breakfast Wrap',
      'description':
          'Organic eggs, beans, sweet potato, spinach and hot sauce in a whole grain wrap',
      'type': 'Breakfast',
      'icon': Icons.breakfast_dining
    },
    {
      'name': 'Superfood Smoothie',
      'description':
          'Organic berries, spinach, banana, almond milk, and plant protein',
      'type': 'Beverage',
      'icon': Icons.blender
    },
    {
      'name': 'Athlete\'s Lunch Box',
      'description':
          'Grilled chicken breast, brown rice, steamed vegetables, and homemade hummus',
      'type': 'Lunch/Dinner',
      'icon': Icons.lunch_dining
    }
  ];

  // Add licenses section
  final List<Map<String, dynamic>> licenses = [
    {
      'title': 'Food Handling & Safety Certificate',
      'issuer': 'Kenya Bureau of Standards',
      'validUntil': 'May 2026'
    },
    {
      'title': 'Organic Food Retail License',
      'issuer': 'Kenya Organic Agriculture Network',
      'validUntil': 'January 2026'
    },
    {
      'title': 'Health Food Preparation Certification',
      'issuer': 'Nairobi County Health Department',
      'validUntil': 'March 2025'
    },
    {
      'title': 'Business Operation Permit',
      'issuer': 'Nairobi City Council',
      'validUntil': 'December 2025'
    }
  ];

  final List<Map<String, dynamic>> suppliers = [
    {
      'name': 'Green Earth Farms',
      'product': 'Organic Fruits & Vegetables',
      'location': 'Kiambu County'
    },
    {
      'name': 'Pure Protein Suppliers',
      'product': 'Lean Meats & Protein Products',
      'location': 'Nairobi'
    },
    {
      'name': 'Vital Supplements Ltd',
      'product': 'Vitamins & Nutritional Supplements',
      'location': 'Mombasa'
    }
  ];

  @override
  Widget build(BuildContext context) {
    // LinkedIn-inspired color scheme (grey)
    final Color primaryColor = Colors.grey[700]!;
    final Color secondaryColor = Colors.grey[500]!;
    final Color backgroundColor = Colors.grey[100]!;
    final Color cardColor = Colors.white;
    final Color accentColor = Colors.grey[800]!;
    final Color borderColor = Colors.grey[300]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Store Profile'),
        backgroundColor: primaryColor,
        actions: [
          // Notifications icon
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          // Messages icon
          IconButton(
            icon: const Icon(Icons.message_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile header stack - LinkedIn style
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Cover image/background
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    border: Border(
                      bottom: BorderSide(color: borderColor, width: 1),
                    ),
                  ),
                ),

                // Store logo positioned to overlap
                Positioned(
                  left: 16,
                  top: 60, // Position to overlap with the cover image
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: cardColor, width: 4),
                      color: backgroundColor,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.storefront,
                        size: 70,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),

                // Edit and share buttons positioned on the right side
                Positioned(
                  right: 16,
                  top: 130,
                  child: Wrap(
                    spacing: 8,
                    children: [
                      // Edit Profile Button
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit Profile'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: accentColor,
                          side: BorderSide(color: borderColor),
                        ),
                      ),
                      // Share Profile Button
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: accentColor,
                          side: BorderSide(color: borderColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Add spacing to accommodate the profile image overlap
            const SizedBox(height: 70),

            // Main content area
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and headline - positioned below the profile image
                  Text(
                    storeName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Business type
                  Text(
                    businessType,
                    style: TextStyle(
                      fontSize: 16,
                      color: secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Basic info
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: secondaryColor),
                      const SizedBox(width: 4),
                      Text(
                        'Nairobi, Kenya',
                        style: TextStyle(color: secondaryColor),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.shopping_bag, size: 16, color: secondaryColor),
                      const SizedBox(width: 4),
                      // Orders button
                      TextButton(
                        onPressed: () {
                          // Handle button press here
                          print('Orders button pressed');
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor: secondaryColor,
                        ),
                        child: Text(
                          '78 monthly orders',
                          style: TextStyle(
                            color: secondaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // About section - LinkedIn style card
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: borderColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'About',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, color: secondaryColor),
                                onPressed: () {},
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            description,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Products section
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: borderColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Product Categories',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: secondaryColor),
                                onPressed: () {},
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...products.map((product) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product category icon
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Icon(
                                        product['icon'],
                                        color: secondaryColor,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // Product details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product['category'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            product['details'],
                                            style: TextStyle(
                                              color: secondaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Menu section (New)
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: borderColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Featured Menu Items',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: secondaryColor),
                                onPressed: () {},
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...menuItems.map((item) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Menu item icon
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Icon(
                                        item['icon'],
                                        color: secondaryColor,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // Menu item details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['name'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            item['description'],
                                            style: TextStyle(
                                              color: secondaryColor,
                                              fontSize: 13,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Type: ${item['type']}',
                                            style: TextStyle(
                                              color: secondaryColor,
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Licenses section (New)
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: borderColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Licenses & Certifications',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: secondaryColor),
                                onPressed: () {},
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...licenses.map((license) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // License icon
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Icon(
                                        Icons.verified,
                                        color: secondaryColor,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // License details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            license['title'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Issued by: ${license['issuer']}',
                                            style: TextStyle(
                                              color: secondaryColor,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Valid until: ${license['validUntil']}',
                                            style: TextStyle(
                                              color: secondaryColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Suppliers section
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: borderColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Key Suppliers',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: secondaryColor),
                                onPressed: () {},
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...suppliers.map((supplier) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Supplier avatar
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: backgroundColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: borderColor),
                                      ),
                                      child: Icon(
                                        Icons.business,
                                        color: secondaryColor,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // Supplier details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            supplier['name'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            supplier['product'],
                                            style: TextStyle(
                                              color: secondaryColor,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Location: ${supplier['location']}',
                                            style: TextStyle(
                                              color: secondaryColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Business hours section
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: borderColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Business Hours',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, color: secondaryColor),
                                onPressed: () {},
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildBusinessHoursItem(
                              'Monday - Friday', '8:00 AM - 8:00 PM'),
                          _buildBusinessHoursItem(
                              'Saturday', '9:00 AM - 6:00 PM'),
                          _buildBusinessHoursItem(
                              'Sunday', '10:00 AM - 4:00 PM'),
                          _buildBusinessHoursItem(
                              'Public Holidays', '10:00 AM - 3:00 PM'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build business hours items
  Widget _buildBusinessHoursItem(String day, String hours) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(Icons.schedule, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            day,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Text(
            hours,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
