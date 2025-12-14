import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiziappp2/technicals/widgets/supportwidget.dart';

class Admingymwearbrandprofile extends StatefulWidget {
  const Admingymwearbrandprofile({super.key});

  @override
  State<Admingymwearbrandprofile> createState() =>
      _AdmingymwearbrandprofileState();
}

class _AdmingymwearbrandprofileState extends State<Admingymwearbrandprofile> {
  // Sample gymwear brand data
  String brandName = "Flex Apparel";
  String businessType = "Athletic & Fitness Clothing Brand";
  String description =
      "Flex Apparel is a premium fitness and activewear brand founded in 2018, dedicated to creating "
      "high-performance clothing for fitness enthusiasts and athletes. Our collections combine "
      "cutting-edge technical fabrics with contemporary designs.";

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // Mutable lists for data
  List<Map<String, dynamic>> productCollections = [
    {
      'title': 'Performance Series',
      'details': 'Moisture-wicking, breathable fabrics for high-intensity training',
      'icon': Icons.bolt
    },
    {
      'title': 'Flex Comfort',
      'details': 'Ultra-soft, stretchy materials for yoga and low-impact activities',
      'icon': Icons.favorite
    },
    {
      'title': 'Endurance Line',
      'details': 'Durable, supportive gear for long-distance runners and athletes',
      'icon': Icons.timer
    },
    {
      'title': 'Urban Fitness',
      'details': 'Stylish athleisure wear for gym-to-street versatility',
      'icon': Icons.style
    }
  ];

  List<Map<String, dynamic>> materials = [
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
  ];

  List<Map<String, dynamic>> licenses = [
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
  ];

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  void _showEditProfileDialog(BuildContext context) {
    final brandNameController = TextEditingController(text: brandName);
    final businessTypeController = TextEditingController(text: businessType);
    final descriptionController = TextEditingController(text: description);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {
                  await _pickImage();
                  Navigator.pop(context);
                  _showEditProfileDialog(context);
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                  child: _profileImage == null
                      ? const Icon(Icons.add_a_photo, size: 30, color: Colors.grey)
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: brandNameController,
                decoration: const InputDecoration(labelText: 'Brand Name'),
              ),
              TextField(
                controller: businessTypeController,
                decoration: const InputDecoration(labelText: 'Business Type'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                brandName = brandNameController.text;
                businessType = businessTypeController.text;
                description = descriptionController.text;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAddCollectionDialog() {
    final titleController = TextEditingController();
    final detailsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Collection'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Collection Title'),
            ),
            TextField(
              controller: detailsController,
              decoration: const InputDecoration(labelText: 'Details'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                productCollections.add({
                  'title': titleController.text,
                  'details': detailsController.text,
                  'icon': Icons.style,
                });
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Black color scheme
    final Color primaryColor = Colors.black;
    final Color secondaryColor = Colors.grey[800]!;
    final Color backgroundColor = Colors.white;
    final Color cardColor = Colors.white;
    final Color accentColor = Colors.black;
    final Color borderColor = Colors.grey[300]!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Apparel Brand Profile', style: AppWidget.boldTextFieledStyle()),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
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
                const SizedBox(height: 180, width: double.infinity),
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
                Positioned(
                  left: 16,
                  top: 60,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: cardColor, width: 4),
                        color: backgroundColor,
                        image: _profileImage != null
                            ? DecorationImage(image: FileImage(_profileImage!), fit: BoxFit.cover)
                            : null,
                      ),
                      child: _profileImage == null
                          ? Center(
                              child: Icon(
                                Icons.accessibility_new,
                                size: 70,
                                color: primaryColor,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 130,
                  child: Wrap(
                    spacing: 8,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () => _showEditProfileDialog(context),
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit Profile'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: accentColor,
                          side: BorderSide(color: borderColor),
                        ),
                      ),
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
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brandName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    businessType,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
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
                                icon: const Icon(Icons.edit, size: 20),
                                onPressed: () => _showEditProfileDialog(context),
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
                                icon: const Icon(Icons.add),
                                onPressed: _showAddCollectionDialog,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...productCollections.asMap().entries.map((entry) {
                            int idx = entry.key;
                            Map<String, dynamic> collection = entry.value;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Icon(
                                      collection['icon'],
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                                    onPressed: () {
                                      setState(() {
                                        productCollections.removeAt(idx);
                                      });
                                    },
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
          ],
        ),
      ),
    );
  }
}
