import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Adminsupplementsstoreprofile extends StatefulWidget {
  const Adminsupplementsstoreprofile({super.key});

  @override
  State<Adminsupplementsstoreprofile> createState() => _AdminsupplementsstoreprofileState();
}

class _AdminsupplementsstoreprofileState extends State<Adminsupplementsstoreprofile> {
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  // Mutable state variables
  String storeName = "VitaFit Supplements";
  String businessType = "Sports Nutrition & Wellness Store";
  String location = "Nairobi, Kenya";
  String description =
      "Established in 2019, VitaFit Supplements is a premium sports nutrition and wellness "
      "store specializing in high-quality supplements, performance enhancers, and fitness "
      "products. We cater to athletes, bodybuilders, fitness enthusiasts, and health-conscious "
      "individuals looking to optimize their performance and wellbeing. Our store features a "
      "wide range of scientifically-backed products from trusted brands, with expert staff "
      "providing personalized recommendations based on individual goals and needs.";

  List<Map<String, dynamic>> products = [
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

  List<Map<String, dynamic>> featuredProducts = [
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

  List<Map<String, dynamic>> certifications = [
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

  List<Map<String, dynamic>> suppliers = [
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

  Map<String, String> businessHours = {
    'Monday - Friday': '7:30 AM - 9:00 PM',
    'Saturday': '8:00 AM - 7:00 PM',
    'Sunday': '9:00 AM - 5:00 PM',
    'Public Holidays': '10:00 AM - 4:00 PM',
  };

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: storeName);
    final typeController = TextEditingController(text: businessType);
    final locationController = TextEditingController(text: location);
    final descController = TextEditingController(text: description);

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
                  _showEditProfileDialog();
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
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Store Name'),
              ),
              TextField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Business Type'),
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'About'),
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
                storeName = nameController.text;
                businessType = typeController.text;
                location = locationController.text;
                description = descController.text;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 47, 47, 49),
              foregroundColor: Colors.white,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAddCategoryDialog() {
    final categoryController = TextEditingController();
    final detailsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Product Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Category Name'),
            ),
            TextField(
              controller: detailsController,
              decoration: const InputDecoration(labelText: 'Details'),
              maxLines: 2,
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
                products.add({
                  'category': categoryController.text,
                  'details': detailsController.text,
                  'icon': Icons.category,
                });
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 47, 47, 49),
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _removeCategory(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  void _showAddFeaturedProductDialog() {
    final nameController = TextEditingController();
    final descController = TextEditingController();
    final typeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Featured Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 2,
            ),
            TextField(
              controller: typeController,
              decoration: const InputDecoration(labelText: 'Type'),
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
                featuredProducts.add({
                  'name': nameController.text,
                  'description': descController.text,
                  'type': typeController.text,
                  'icon': Icons.star,
                });
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 47, 47, 49),
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _removeFeaturedProduct(int index) {
    setState(() {
      featuredProducts.removeAt(index);
    });
  }

  void _showAddCertificationDialog() {
    final titleController = TextEditingController();
    final issuerController = TextEditingController();
    final validController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Certification'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: issuerController,
              decoration: const InputDecoration(labelText: 'Issuer'),
            ),
            TextField(
              controller: validController,
              decoration: const InputDecoration(labelText: 'Valid Until'),
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
                certifications.add({
                  'title': titleController.text,
                  'issuer': issuerController.text,
                  'validUntil': validController.text,
                });
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 47, 47, 49),
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _removeCertification(int index) {
    setState(() {
      certifications.removeAt(index);
    });
  }

  void _showAddSupplierDialog() {
    final nameController = TextEditingController();
    final productController = TextEditingController();
    final locationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Supplier'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Supplier Name'),
            ),
            TextField(
              controller: productController,
              decoration: const InputDecoration(labelText: 'Product'),
            ),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Location'),
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
                suppliers.add({
                  'name': nameController.text,
                  'product': productController.text,
                  'location': locationController.text,
                });
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 47, 47, 49),
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _removeSupplier(int index) {
    setState(() {
      suppliers.removeAt(index);
    });
  }

  void _showEditBusinessHoursDialog() {
    final controllers = <String, TextEditingController>{};
    businessHours.forEach((key, value) {
      controllers[key] = TextEditingController(text: value);
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Business Hours'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: businessHours.keys.map((day) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TextField(
                  controller: controllers[day],
                  decoration: InputDecoration(labelText: day),
                ),
              );
            }).toList(),
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
                controllers.forEach((key, controller) {
                  businessHours[key] = controller.text;
                });
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 47, 47, 49),
              foregroundColor: Colors.white,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dark grey color scheme matching bottom nav
    final Color primaryColor = const Color.fromARGB(255, 47, 47, 49);
    final Color secondaryColor = Colors.grey[600]!;
    final Color backgroundColor = Colors.grey[100]!;
    final Color cardColor = Colors.white;
    final Color borderColor = Colors.grey[300]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplements Store Profile'),
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
            Stack(
              clipBehavior: Clip.none,
              children: [
                const SizedBox(
                  height: 180,
                  width: double.infinity,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 120,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      border: Border(
                        bottom: BorderSide(color: borderColor, width: 1),
                      ),
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
                            ? DecorationImage(
                                image: FileImage(_profileImage!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _profileImage == null
                          ? Center(
                              child: Icon(
                                Icons.fitness_center,
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
                        onPressed: _showEditProfileDialog,
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit Profile'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: primaryColor,
                          side: BorderSide(color: borderColor),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: primaryColor,
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
                    storeName,
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
                      color: secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: secondaryColor),
                      const SizedBox(width: 4),
                      Text(location, style: TextStyle(color: secondaryColor)),
                      const SizedBox(width: 16),
                      Icon(Icons.shopping_bag, size: 16, color: secondaryColor),
                      const SizedBox(width: 4),
                      Text('92 monthly orders', style: TextStyle(color: secondaryColor)),
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
                                onPressed: _showEditProfileDialog,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(description, style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Product Categories
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
                                onPressed: _showAddCategoryDialog,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...products.asMap().entries.map((entry) {
                            int index = entry.key;
                            var product = entry.value;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: backgroundColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Icon(product['icon'], color: secondaryColor),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product['category'],
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          product['details'],
                                          style: TextStyle(color: secondaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                                    onPressed: () => _removeCategory(index),
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

                  // Featured Products
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
                                onPressed: _showAddFeaturedProductDialog,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...featuredProducts.asMap().entries.map((entry) {
                            int index = entry.key;
                            var item = entry.value;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: backgroundColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Icon(item['icon'], color: secondaryColor),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['name'],
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          item['description'],
                                          style: TextStyle(color: secondaryColor, fontSize: 13),
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
                                  IconButton(
                                    icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                                    onPressed: () => _removeFeaturedProduct(index),
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

                  // Certifications
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
                                onPressed: _showAddCertificationDialog,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...certifications.asMap().entries.map((entry) {
                            int index = entry.key;
                            var cert = entry.value;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: backgroundColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Icon(Icons.verified, color: secondaryColor),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cert['title'],
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Issued by: ${cert['issuer']}',
                                          style: TextStyle(color: secondaryColor),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Valid until: ${cert['validUntil']}',
                                          style: TextStyle(color: secondaryColor, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                                    onPressed: () => _removeCertification(index),
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

                  // Suppliers
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
                                onPressed: _showAddSupplierDialog,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...suppliers.asMap().entries.map((entry) {
                            int index = entry.key;
                            var supplier = entry.value;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: backgroundColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: borderColor),
                                    ),
                                    child: Icon(Icons.business, color: secondaryColor),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          supplier['name'],
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          supplier['product'],
                                          style: TextStyle(color: secondaryColor),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Location: ${supplier['location']}',
                                          style: TextStyle(color: secondaryColor, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                                    onPressed: () => _removeSupplier(index),
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

                  // Business Hours
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
                                onPressed: _showEditBusinessHoursDialog,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ...businessHours.entries.map((entry) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  Icon(Icons.schedule, size: 16, color: Colors.grey),
                                  const SizedBox(width: 8),
                                  Text(
                                    entry.key,
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  const Spacer(),
                                  Text(
                                    entry.value,
                                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}