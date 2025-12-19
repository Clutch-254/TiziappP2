import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Addfoodpage extends StatefulWidget {
  const Addfoodpage({super.key});

  @override
  State<Addfoodpage> createState() => _AddfoodpageState();
}

class _AddfoodpageState extends State<Addfoodpage> {
  List<Map<String, dynamic>> foodItems = [
    {
      'name': 'Green Power Bowl',
      'description': 'Organic kale, spinach, avocado, quinoa, grilled chicken',
      'price': 850.00,
      'category': 'Lunch/Dinner',
      'image': null,
    },
    {
      'name': 'Protein Breakfast Wrap',
      'description': 'Organic eggs, beans, sweet potato, spinach in whole grain wrap',
      'price': 650.00,
      'category': 'Breakfast',
      'image': null,
    },
    {
      'name': 'Superfood Smoothie',
      'description': 'Organic berries, spinach, banana, almond milk, plant protein',
      'price': 400.00,
      'category': 'Beverage',
      'image': null,
    },
    {
      'name': 'Athlete\'s Lunch Box',
      'description': 'Grilled chicken breast, brown rice, steamed vegetables',
      'price': 950.00,
      'category': 'Lunch/Dinner',
      'image': null,
    },
  ];

  final List<String> categories = [
    'Breakfast',
    'Lunch/Dinner',
    'Beverage',
    'Snack',
    'Dessert',
  ];

  String selectedCategory = 'All';
  final ImagePicker _picker = ImagePicker();

  List<Map<String, dynamic>> get filteredFoodItems {
    if (selectedCategory == 'All') {
      return foodItems;
    }
    return foodItems.where((item) => item['category'] == selectedCategory).toList();
  }

  Future<File?> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  void _showAddFoodDialog({Map<String, dynamic>? existingFood, int? index}) {
    final nameController = TextEditingController(text: existingFood?['name'] ?? '');
    final descController = TextEditingController(text: existingFood?['description'] ?? '');
    final priceController = TextEditingController(
      text: existingFood != null ? existingFood['price'].toString() : '',
    );
    String selectedCat = existingFood?['category'] ?? categories[0];
    File? selectedImage = existingFood?['image'];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(existingFood != null ? 'Edit Food Item' : 'Add Food Item'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image picker
                GestureDetector(
                  onTap: () async {
                    final image = await _pickImage();
                    if (image != null) {
                      setDialogState(() {
                        selectedImage = image;
                      });
                    }
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      image: selectedImage != null
                          ? DecorationImage(
                              image: FileImage(selectedImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: selectedImage == null
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_photo_alternate, size: 40, color: Colors.grey),
                              SizedBox(height: 8),
                              Text('Add Image', style: TextStyle(color: Colors.grey)),
                            ],
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Food Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price (KSh)',
                    border: OutlineInputBorder(),
                    prefixText: 'KSh ',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedCat,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  items: categories.map((cat) {
                    return DropdownMenuItem(
                      value: cat,
                      child: Text(cat),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setDialogState(() {
                      selectedCat = value!;
                    });
                  },
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
                if (nameController.text.isEmpty || priceController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all required fields')),
                  );
                  return;
                }

                final foodData = {
                  'name': nameController.text,
                  'description': descController.text,
                  'price': double.tryParse(priceController.text) ?? 0.0,
                  'category': selectedCat,
                  'image': selectedImage,
                };

                setState(() {
                  if (existingFood != null && index != null) {
                    foodItems[index] = foodData;
                  } else {
                    foodItems.add(foodData);
                  }
                });

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(existingFood != null
                        ? 'Food item updated successfully'
                        : 'Food item added successfully'),
                    backgroundColor: Colors.grey[700],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700],
                foregroundColor: Colors.white,
              ),
              child: Text(existingFood != null ? 'Update' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Food Item'),
        content: Text('Are you sure you want to delete "${foodItems[index]['name']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                foodItems.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Food item deleted'),
                  backgroundColor: Colors.grey[700],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.grey[700]!;
    final displayedItems = filteredFoodItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Food Items'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildCategoryChip('All'),
                ...categories.map((cat) => _buildCategoryChip(cat)),
              ],
            ),
          ),

          // Food Items Grid
          Expanded(
            child: displayedItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.restaurant_menu, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'No food items in this category',
                          style: TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: displayedItems.length,
                    itemBuilder: (context, index) {
                      final actualIndex = foodItems.indexOf(displayedItems[index]);
                      final item = displayedItems[index];
                      
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Food Image
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  image: item['image'] != null
                                      ? DecorationImage(
                                          image: FileImage(item['image']),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: item['image'] == null
                                    ? const Center(
                                        child: Icon(
                                          Icons.restaurant,
                                          size: 48,
                                          color: Colors.grey,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                            
                            // Food Details
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['description'],
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'KSh ${item['price'].toStringAsFixed(0)}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: () => _showAddFoodDialog(
                                              existingFood: item,
                                              index: actualIndex,
                                            ),
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: Colors.blue[50],
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: const Icon(
                                                Icons.edit,
                                                size: 16,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          InkWell(
                                            onTap: () => _showDeleteConfirmation(actualIndex),
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: Colors.red[50],
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: const Icon(
                                                Icons.delete,
                                                size: 16,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddFoodDialog(),
        backgroundColor: primaryColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Food', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final isSelected = selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(category),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            selectedCategory = category;
          });
        },
        selectedColor: Colors.grey[700],
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[700],
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}