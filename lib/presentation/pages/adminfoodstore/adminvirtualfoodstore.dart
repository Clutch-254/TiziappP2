import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Adminvirtualfoodstore extends StatefulWidget {
  const Adminvirtualfoodstore({super.key});

  @override
  State<Adminvirtualfoodstore> createState() => _AdminvirtualfoodstoreState();
}

class _AdminvirtualfoodstoreState extends State<Adminvirtualfoodstore> {
  // Mutable state variables
  String storeName = "Healthy Bites Market";
  String businessType = "Organic Food & Nutrition Store";
  String description =
      "Established in 2018, Healthy Bites Market is a premium nutrition-focused food store "
      "specializing in organic produce, whole foods, and healthy meal options. We offer a wide "
      "selection of high-quality ingredients for health-conscious individuals, fitness enthusiasts, "
      "and those with specific dietary needs. Our store features locally sourced organic produce, "
      "protein-rich foods, and pre-prepared healthy meals designed by nutritionists "
      "to support various fitness and health goals.";

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  List<Map<String, dynamic>> products = [
    {
      'category': 'Organic Produce',
      'details': 'Locally sourced fruits and vegetables from certified organic farms',
      'icon': Icons.eco
    },
    {
      'category': 'Protein Foods',
      'details': 'High-quality lean meats, plant proteins, and protein supplements',
      'icon': Icons.egg_alt
    },
    {
      'category': 'Prepared Meals',
      'details': 'Nutritionist-designed balanced meals for various dietary requirements',
      'icon': Icons.lunch_dining
    }
  ];

  List<Map<String, dynamic>> menuItems = [
    {
      'name': 'Green Power Bowl',
      'description': 'Organic kale, spinach, avocado, quinoa, grilled chicken, and lemon tahini dressing',
      'type': 'Lunch/Dinner',
      'icon': Icons.restaurant_menu
    },
    {
      'name': 'Protein Breakfast Wrap',
      'description': 'Organic eggs, beans, sweet potato, spinach and hot sauce in a whole grain wrap',
      'type': 'Breakfast',
      'icon': Icons.breakfast_dining
    },
    {
      'name': 'Superfood Smoothie',
      'description': 'Organic berries, spinach, banana, almond milk, and plant protein',
      'type': 'Beverage',
      'icon': Icons.blender
    },
    {
      'name': 'Athlete\'s Lunch Box',
      'description': 'Grilled chicken breast, brown rice, steamed vegetables, and homemade hummus',
      'type': 'Lunch/Dinner',
      'icon': Icons.lunch_dining
    }
  ];

  List<Map<String, dynamic>> licenses = [
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

  List<Map<String, dynamic>> suppliers = [
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

  List<Map<String, String>> businessHours = [
    {'day': 'Monday - Friday', 'hours': '8:00 AM - 8:00 PM'},
    {'day': 'Saturday', 'hours': '9:00 AM - 6:00 PM'},
    {'day': 'Sunday', 'hours': '10:00 AM - 4:00 PM'},
    {'day': 'Public Holidays', 'hours': '10:00 AM - 3:00 PM'},
  ];

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
                description = descController.text;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[700],
              foregroundColor: Colors.white,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAddProductCategoryDialog() {
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
              backgroundColor: Colors.grey[700],
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _removeProductCategory(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  void _showAddMenuItemDialog() {
    final nameController = TextEditingController();
    final descController = TextEditingController();
    final typeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Menu Item'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 2,
              ),
              TextField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Type (e.g., Breakfast, Lunch)'),
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
                menuItems.add({
                  'name': nameController.text,
                  'description': descController.text,
                  'type': typeController.text,
                  'icon': Icons.restaurant_menu,
                });
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[700],
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _removeMenuItem(int index) {
    setState(() {
      menuItems.removeAt(index);
    });
  }

  void _showAddLicenseDialog() {
    final titleController = TextEditingController();
    final issuerController = TextEditingController();
    final validController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add License'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'License Name'),
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
                licenses.add({
                  'title': titleController.text,
                  'issuer': issuerController.text,
                  'validUntil': validController.text,
                });
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[700],
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _removeLicense(int index) {
    setState(() {
      licenses.removeAt(index);
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
              backgroundColor: Colors.grey[700],
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
    List<TextEditingController> controllers = businessHours.map((e) => TextEditingController(text: e['hours'])).toList();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Business Hours'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(businessHours.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  controller: controllers[index],
                  decoration: InputDecoration(labelText: businessHours[index]['day']),
                ),
              );
            }),
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
                for (int i = 0; i < businessHours.length; i++) {
                  businessHours[i]['hours'] = controllers[i].text;
                }
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[700],
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
    // Color scheme matching bottom nav
    final Color primaryColor = Colors.grey[700]!;
    final Color secondaryColor = Colors.grey[500]!;
    final Color backgroundColor = Colors.grey[100]!;
    final Color cardColor = Colors.white;
    final Color accentColor = Colors.grey[700]!;
    final Color borderColor = Colors.grey[300]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Store Profile'),
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
                                Icons.storefront,
                                size: 70,
                                color: primaryColor,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Edit and share buttons positioned below the stack
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Wrap(
                  spacing: 8,
                  children: [
                    OutlinedButton.icon(
                      onPressed: _showEditProfileDialog,
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
            ),

            const SizedBox(height: 20),

            // Main content area
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

                  // Basic info
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: secondaryColor),
                      const SizedBox(width: 4),
                      Text('Nairobi, Kenya', style: TextStyle(color: secondaryColor)),
                      const SizedBox(width: 16),
                      Icon(Icons.shopping_bag, size: 16, color: secondaryColor),
                      const SizedBox(width: 4),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
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

                  // Product Categories section
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
                                onPressed: _showAddProductCategoryDialog,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...products.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, dynamic> product = entry.value;
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
                                    onPressed: () => _removeProductCategory(index),
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

                  // Featured Menu Items section
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
                                onPressed: _showAddMenuItemDialog,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...menuItems.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, dynamic> item = entry.value;
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
                                  IconButton(
                                    icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                                    onPressed: () => _removeMenuItem(index),
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
                                onPressed: _showAddLicenseDialog,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...licenses.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, dynamic> license = entry.value;
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
                                          license['title'],
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Issued by: ${license['issuer']}',
                                          style: TextStyle(color: secondaryColor),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Valid until: ${license['validUntil']}',
                                          style: TextStyle(color: secondaryColor, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                                    onPressed: () => _removeLicense(index),
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
                                onPressed: _showAddSupplierDialog,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...suppliers.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, dynamic> supplier = entry.value;
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
                                onPressed: _showEditBusinessHoursDialog,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ...businessHours.map((e) => _buildBusinessHoursItem(e['day']!, e['hours']!)),
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

  Widget _buildBusinessHoursItem(String day, String hours) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(Icons.schedule, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(day, style: const TextStyle(fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(
            hours,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }
}
