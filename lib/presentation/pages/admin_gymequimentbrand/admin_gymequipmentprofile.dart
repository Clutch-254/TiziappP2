import 'package:flutter/material.dart';

class AdminGymequipmentprofile extends StatefulWidget {
  const AdminGymequipmentprofile({super.key});

  @override
  State<AdminGymequipmentprofile> createState() =>
      _AdminGymequipmentprofileState();
}

class _AdminGymequipmentprofileState extends State<AdminGymequipmentprofile> {
  // Sample gym equipment brand data
  final String brandName = "PowerPro Fitness Equipment";
  final String businessType = "Gym Equipment Manufacturer & Supplier";
  final String description =
      "PowerPro Fitness Equipment is a leading manufacturer and supplier of premium gym equipment "
      "established in 2010. We specialize in designing and producing high-quality strength training, "
      "cardio, and functional training equipment for commercial and home gyms. Our products are "
      "known for their durability, innovative design, and ergonomic features. We take pride in our "
      "commitment to quality control and customer satisfaction, offering comprehensive warranties "
      "and responsive after-sales service to fitness centers across East Africa.";

  final List<Map<String, dynamic>> productCategories = [
    {
      'title': 'Strength Equipment',
      'details': 'Free weights, weight machines, racks, and benches',
      'icon': Icons.fitness_center
    },
    {
      'title': 'Cardio Equipment',
      'details': 'Treadmills, ellipticals, bikes, and rowing machines',
      'icon': Icons.directions_run
    },
    {
      'title': 'Functional Training',
      'details': 'Battle ropes, kettlebells, medicine balls, and TRX systems',
      'icon': Icons.sports_gymnastics
    },
    {
      'title': 'Accessories',
      'details': 'Mats, resistance bands, foam rollers, and weight plates',
      'icon': Icons.sports
    }
  ];

  final List<Map<String, dynamic>> certifications = [
    {
      'title': 'ISO 9001:2015 Quality Management',
      'issuer': 'International Organization for Standardization',
      'validUntil': 'January 2026'
    },
    {
      'title': 'CE Certification for Equipment Safety',
      'issuer': 'European Conformity Certification Body',
      'validUntil': 'March 2027'
    },
    {
      'title': 'Kenya Bureau of Standards Quality Mark',
      'issuer': 'Kenya Bureau of Standards',
      'validUntil': 'October 2025'
    },
    {
      'title': 'East African Community Certification',
      'issuer': 'EAC Standards Commission',
      'validUntil': 'April 2026'
    }
  ];

  @override
  Widget build(BuildContext context) {
    // LinkedIn-inspired color scheme (blue)
    final Color primaryColor = Colors.blue[800]!;
    final Color secondaryColor = Colors.blue[600]!;
    final Color backgroundColor = Colors.grey[100]!;
    final Color cardColor = Colors.white;
    final Color accentColor = Colors.blue[900]!;
    final Color borderColor = Colors.grey[300]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gym Equipment Brand Profile'),
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
                      Icon(Icons.store, size: 16, color: secondaryColor),
                      const SizedBox(width: 4),
                      // Clients button
                      TextButton(
                        onPressed: () {
                          // Handle button press here
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
                          '76 retailers',
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

                  // Product Categories section (replacing Facilities)
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
                          ...productCategories.map((category) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Category icon
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Icon(
                                        category['icon'],
                                        color: secondaryColor,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // Category details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            category['title'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            category['details'],
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

                  // Certifications section (replacing Licenses)
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
                                'Certifications & Standards',
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
                              'Monday - Friday', '8:00 AM - 5:00 PM'),
                          _buildBusinessHoursItem(
                              'Saturday', '9:00 AM - 3:00 PM'),
                          _buildBusinessHoursItem('Sunday', 'Closed'),
                          _buildBusinessHoursItem('Public Holidays', 'Closed'),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Warranty Information section (new section)
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
                                'Warranty Information',
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
                          _buildWarrantyItem('Strength Equipment',
                              '5 years on frame, 2 years on parts'),
                          _buildWarrantyItem('Cardio Equipment',
                              '3 years on motor, 2 years on electronics'),
                          _buildWarrantyItem('Functional Training',
                              '2 years on materials and workmanship'),
                          _buildWarrantyItem(
                              'Accessories', '1 year limited warranty'),
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

  // Helper method to build warranty items
  Widget _buildWarrantyItem(String productType, String warranty) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.verified_user, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productType,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 2),
                Text(
                  warranty,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
