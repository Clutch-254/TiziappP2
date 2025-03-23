import 'package:flutter/material.dart';

class Adminsupplementsstoreprofile extends StatefulWidget {
  const Adminsupplementsstoreprofile({super.key});

  @override
  State<Adminsupplementsstoreprofile> createState() => _AdminsupplementsstoreprofileState();
}

class _AdminsupplementsstoreprofileState extends State<Adminsupplementsstoreprofile> {
  // Sample supplements store data
  final String storeName = "VitaFit Supplements";
  final String businessType = "Sports Nutrition & Wellness Store";
  final String description =
      "Established in 2019, VitaFit Supplements is a premium sports nutrition and wellness "
      "store specializing in high-quality supplements, performance enhancers, and fitness "
      "products. We cater to athletes, bodybuilders, fitness enthusiasts, and health-conscious "
      "individuals looking to optimize their performance and wellbeing. Our store features a "
      "wide range of scientifically-backed products from trusted brands, with expert staff "
      "providing personalized recommendations based on individual goals and needs.";

  // Products list
  final List<Map<String, dynamic>> products = [
    {
      'category': 'Protein Supplements',
      'details':
          'Whey, plant-based, and specialized protein powders for muscle recovery and growth',
      'icon': Icons.fitness_center
    },
    {
      'category': 'Performance Enhancers',
      'details':
          'Pre-workouts, BCAAs, creatine, and energy boosters for optimal training',
      'icon': Icons.bolt
    },
    {
      'category': 'Wellness & Recovery',
      'details':
          'Joint support, omega-3s, multivitamins, and recovery supplements',
      'icon': Icons.health_and_safety
    }
  ];

  // Featured products
  final List<Map<String, dynamic>> featuredProducts = [
    {
      'name': 'Ultimate Whey Protein',
      'description':
          '25g of premium whey isolate per serving, with minimal fat and carbs, in multiple flavors',
      'type': 'Protein',
      'icon': Icons.fitness_center
    },
    {
      'name': 'Pre-Workout Extreme',
      'description':
          'Energy-boosting formula with caffeine, beta-alanine, and citrulline malate for maximum performance',
      'type': 'Performance',
      'icon': Icons.bolt
    },
    {
      'name': 'Joint Support Complex',
      'description':
          'Complete formula with glucosamine, chondroitin, MSM, and turmeric for joint health',
      'type': 'Wellness',
      'icon': Icons.healing
    },
    {
      'name': 'Multivitamin Elite',
      'description':
          'Comprehensive vitamin and mineral blend tailored for active individuals',
      'type': 'Wellness',
      'icon': Icons.health_and_safety
    }
  ];

  // Certifications section
  final List<Map<String, dynamic>> certifications = [
    {
      'title': 'Good Manufacturing Practice (GMP) Certified',
      'issuer': 'International GMP Association',
      'validUntil': 'June 2026'
    },
    {
      'title': 'Sports Nutrition Specialist Certification',
      'issuer': 'Kenya Nutrition Association',
      'validUntil': 'March 2026'
    },
    {
      'title': 'Dietary Supplement Retail License',
      'issuer': 'Kenya Pharmacy and Poisons Board',
      'validUntil': 'February 2025'
    },
    {
      'title': 'Business Operation Permit',
      'issuer': 'Nairobi City Council',
      'validUntil': 'December 2025'
    }
  ];

  // Suppliers list
  final List<Map<String, dynamic>> suppliers = [
    {
      'name': 'PurePro Nutrition',
      'product': 'Protein & Performance Supplements',
      'location': 'Nairobi'
    },
    {
      'name': 'Global Vitamin Labs',
      'product': 'Vitamins & Minerals',
      'location': 'Mombasa'
    },
    {
      'name': 'Natural Wellness Kenya',
      'product': 'Herbal & Natural Supplements',
      'location': 'Nakuru'
    }
  ];

  @override
  Widget build(BuildContext context) {
    // LinkedIn-inspired color scheme (blue)
    final Color primaryColor = Colors.blue[800]!;
    final Color secondaryColor = Colors.blue[500]!;
    final Color backgroundColor = Colors.blue[50]!;
    final Color cardColor = Colors.white;
    final Color accentColor = Colors.blue[900]!;
    final Color borderColor = Colors.blue[100]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplements Store Profile'),
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
                        Icons.fitness_center,
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
                          '92 monthly orders',
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

                  // Featured Products section
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
                                'Featured Products',
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
                          ...featuredProducts.map((item) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product icon
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
                                    // Product details
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
                                            'Category: ${item['type']}',
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

                  // Certifications section
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
                                'Certifications',
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
                          ...certifications.map((cert) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Certification icon
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
                                    // Certification details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cert['title'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Issued by: ${cert['issuer']}',
                                            style: TextStyle(
                                              color: secondaryColor,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Valid until: ${cert['validUntil']}',
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
                              'Monday - Friday', '7:30 AM - 9:00 PM'),
                          _buildBusinessHoursItem(
                              'Saturday', '8:00 AM - 7:00 PM'),
                          _buildBusinessHoursItem(
                              'Sunday', '9:00 AM - 5:00 PM'),
                          _buildBusinessHoursItem(
                              'Public Holidays', '10:00 AM - 4:00 PM'),
                        ],
                      ),
                    ),
                  ),

                  // Additional section: Customer Reviews
                  const SizedBox(height: 16),
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
                                'Customer Reviews',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '4.7',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: secondaryColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(Icons.star, color: Colors.amber, size: 20),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildReviewItem(
                            'John Kamau',
                            'Great selection of protein powders, and the staff is very knowledgeable!',
                            4.5,
                            '2 weeks ago',
                          ),
                          _buildReviewItem(
                            'Sarah Njoroge',
                            'I love their pre-workout supplements. Really helps with my morning gym sessions.',
                            5.0,
                            '1 month ago',
                          ),
                          _buildReviewItem(
                            'Michael Odhiambo',
                            'Prices are a bit high, but the quality is worth it. Their multivitamins have improved my recovery significantly.',
                            4.0,
                            '3 months ago',
                          ),
                          
                          // See all reviews button
                          Center(
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'See all 47 reviews',
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Add some space at the bottom
                  const SizedBox(height: 20),
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
  
  // Helper method to build review items
  Widget _buildReviewItem(String name, String comment, double rating, String timeAgo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // User avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    name[0],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // User name and rating
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        // Star rating
                        ...List.generate(5, (index) {
                          if (index < rating.floor()) {
                            return Icon(Icons.star, color: Colors.amber, size: 16);
                          } else if (index == rating.floor() && rating % 1 > 0) {
                            return Icon(Icons.star_half, color: Colors.amber, size: 16);
                          } else {
                            return Icon(Icons.star_border, color: Colors.amber, size: 16);
                          }
                        }),
                        const SizedBox(width: 8),
                        // Time ago
                        Text(
                          timeAgo,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Review comment
          Text(
            comment,
            style: const TextStyle(fontSize: 14),
          ),
          const Divider(height: 24),
        ],
      ),
    );
  }
}