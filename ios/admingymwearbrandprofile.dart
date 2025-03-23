import 'package:flutter/material.dart';

class Admingymwearbrandprofile extends StatefulWidget {
  const Admingymwearbrandprofile({super.key});

  @override
  State<Admingymwearbrandprofile> createState() =>
      _AdmingymwearbrandprofileState();
}

class _AdmingymwearbrandprofileState extends State<Admingymwearbrandprofile> {
  // Sample gymwear brand data
  final String brandName = "Flex Apparel";
  final String businessType = "Athletic & Fitness Clothing Brand";
  final String description =
      "Flex Apparel is a premium fitness and activewear brand founded in 2018, dedicated to creating "
      "high-performance clothing for fitness enthusiasts and athletes. Our collections combine "
      "cutting-edge technical fabrics with contemporary designs, providing optimal comfort, "
      "functionality, and style for all types of workouts. We pride ourselves on sustainable "
      "manufacturing practices, using eco-friendly materials where possible, and ethical production "
      "processes. Our range includes performance leggings, sports bras, training tops, shorts, "
      "outerwear, and fitness accessories designed for both men and women.";

  final List<Map<String, dynamic>> productCollections = [
    {
      'title': 'Performance Series',
      'details':
          'Moisture-wicking, breathable fabrics for high-intensity training',
      'icon': Icons.bolt
    },
    {
      'title': 'Flex Comfort',
      'details':
          'Ultra-soft, stretchy materials for yoga and low-impact activities',
      'icon': Icons.favorite
    },
    {
      'title': 'Endurance Line',
      'details':
          'Durable, supportive gear for long-distance runners and athletes',
      'icon': Icons.timer
    },
    {
      'title': 'Urban Fitness',
      'details': 'Stylish athleisure wear for gym-to-street versatility',
      'icon': Icons.style
    }
  ];

  final List<Map<String, dynamic>> materials = [
    {
      'title': 'EcoFlex Fabric',
      'details': 'Recycled polyester blend with 4-way stretch',
      'sustainabilityScore': '90%'
    },
    {
      'title': 'BreatheTech Mesh',
      'details': 'Lightweight, ventilated material for maximum airflow',
      'sustainabilityScore': '85%'
    },
    {
      'title': 'CompressionWeave',
      'details': 'High-density fabric with muscle support properties',
      'sustainabilityScore': '75%'
    },
    {
      'title': 'ThermoRegulate',
      'details': 'Temperature-controlling material for all seasons',
      'sustainabilityScore': '80%'
    }
  ];

  final List<Map<String, dynamic>> licenses = [
    {
      'title': 'Manufacturing License',
      'number': 'MFG-2023-45678',
      'issuedBy': 'Kenya Bureau of Standards',
      'validUntil': 'December 31, 2025'
    },
    {
      'title': 'Export License',
      'number': 'EXP-2024-12345',
      'issuedBy': 'Ministry of Trade and Industry',
      'validUntil': 'March 15, 2026'
    },
    {
      'title': 'Eco-Friendly Certification',
      'number': 'ECO-2024-98765',
      'issuedBy': 'Global Sustainable Textile Alliance',
      'validUntil': 'October 10, 2026'
    }
  ];

  @override
  Widget build(BuildContext context) {
    // Grey color scheme
    final Color primaryColor = Colors.grey[700]!;
    final Color secondaryColor = Colors.grey[500]!;
    final Color backgroundColor = Colors.grey[100]!;
    final Color cardColor = Colors.white;
    final Color accentColor = Colors.grey[800]!;
    final Color borderColor = Colors.grey[300]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Apparel Brand Profile'),
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
            // Profile header stack
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

                // Brand logo positioned to overlap
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
                        Icons.accessibility_new,
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
                  // Name and headline
                  Text(
                    brandName,
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
                      Icon(Icons.people, size: 16, color: secondaryColor),
                      const SizedBox(width: 4),
                      // Retailers button
                      TextButton(
                        onPressed: () {
                          print('Retailers button pressed');
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor: secondaryColor,
                        ),
                        child: Text(
                          '42 retailers',
                          style: TextStyle(
                            color: secondaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // About section
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

                  // Product Collections section
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
                                'Product Collections',
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
                          ...productCollections.map((collection) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Collection icon
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Icon(
                                        collection['icon'],
                                        color: secondaryColor,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // Collection details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            collection['title'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            collection['details'],
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

                  // Materials section
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
                                'Materials & Sustainability',
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
                          ...materials.map((material) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Material icon
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Icon(
                                        Icons.eco,
                                        color: secondaryColor,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // Material details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            material['title'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            material['details'],
                                            style: TextStyle(
                                              color: secondaryColor,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Text(
                                                'Sustainability Score: ',
                                                style: TextStyle(
                                                  color: secondaryColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                material['sustainabilityScore'],
                                                style: TextStyle(
                                                  color: Colors.green[600],
                                                  fontWeight: FontWeight.bold,
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
                              )),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Licenses section
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
                                          Row(
                                            children: [
                                              Text(
                                                'License No: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Text(
                                                license['number'],
                                                style: TextStyle(
                                                  color: secondaryColor,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Text(
                                                'Issued By: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Text(
                                                license['issuedBy'],
                                                style: TextStyle(
                                                  color: secondaryColor,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Text(
                                                'Valid Until: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Text(
                                                license['validUntil'],
                                                style: TextStyle(
                                                  color: license['validUntil']
                                                          .contains('2026')
                                                      ? Colors.green[600]
                                                      : secondaryColor,
                                                  fontWeight:
                                                      license['validUntil']
                                                              .contains('2026')
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
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

                  // Size Guide section
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
                                'Size Guide',
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
                            'Our sizing is designed to be inclusive and accommodate various body types. For detailed measurements and fit guides, please refer to specific product pages.',
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.straighten),
                                label: const Text('View Size Chart'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: accentColor,
                                  side: BorderSide(color: borderColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Care Instructions section
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
                                'Care Instructions',
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
                          _buildCareInstructionItem(
                              'Washing', 'Machine wash cold with like colors'),
                          _buildCareInstructionItem(
                              'Drying', 'Tumble dry low or hang to dry'),
                          _buildCareInstructionItem(
                              'Ironing', 'Do not iron printed graphics'),
                          _buildCareInstructionItem(
                              'Bleaching', 'Do not use bleach'),
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
      // Bottom navigation bar has been removed
    );
  }

  // Helper method to build care instruction items
  Widget _buildCareInstructionItem(String category, String instruction) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.local_laundry_service, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            category + ': ',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Text(
              instruction,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
