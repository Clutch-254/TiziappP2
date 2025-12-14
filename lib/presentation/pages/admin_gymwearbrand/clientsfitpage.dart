import 'package:flutter/material.dart';
import 'package:tiziappp2/technicals/widgets/supportwidget.dart';

class Clientsfitpage extends StatefulWidget {
  const Clientsfitpage({super.key});

  @override
  State<Clientsfitpage> createState() => _ClientsfitpageState();
}

class _ClientsfitpageState extends State<Clientsfitpage> {
  // Nested inventory structure
  Map<String, dynamic> inventory = {
    "Men's": {
      "Upper Body": {
        "T-Shirts": [
          {"name": "Performance Tee", "stock": 50, "price": 25.0},
          {"name": "Muscle Tank", "stock": 30, "price": 20.0},
        ],
        "Hoodies & Jackets": [
          {"name": "Zip-Up Hoodie", "stock": 20, "price": 55.0},
          {"name": "Windbreaker", "stock": 15, "price": 60.0},
        ],
      },
      "Lower Body": {
        "Shorts": [
          {"name": "Running Shorts", "stock": 40, "price": 30.0},
          {"name": "Compression Shorts", "stock": 25, "price": 28.0},
        ],
        "Pants": [
          {"name": "Joggers", "stock": 35, "price": 45.0},
          {"name": "Track Pants", "stock": 20, "price": 50.0},
        ],
      },
      "Footwear": [
        {"name": "Running Shoes", "stock": 10, "price": 120.0},
        {"name": "Training Shoes", "stock": 15, "price": 110.0},
      ],
      "Accessories": [
        {"name": "Caps", "stock": 60, "price": 15.0},
        {"name": "Wristbands", "stock": 100, "price": 8.0},
      ],
    },
    "Women's": {
      "Upper Body": {
        "Sports Bras": [
          {"name": "High Impact Bra", "stock": 45, "price": 35.0},
          {"name": "Seamless Bra", "stock": 50, "price": 30.0},
        ],
        "Tops": [
          {"name": "Crop Top", "stock": 40, "price": 25.0},
          {"name": "Racerback Tank", "stock": 35, "price": 22.0},
        ],
      },
      "Lower Body": {
        "Leggings": [
          {"name": "High-Waisted Leggings", "stock": 60, "price": 50.0},
          {"name": "Capri Leggings", "stock": 30, "price": 45.0},
        ],
        "Shorts": [
          {"name": "Biker Shorts", "stock": 25, "price": 35.0},
          {"name": "Running Shorts", "stock": 20, "price": 30.0},
        ],
      },
      "Footwear": [
        {"name": "Running Shoes", "stock": 12, "price": 120.0},
        {"name": "Training Shoes", "stock": 18, "price": 110.0},
      ],
      "Accessories": [
        {"name": "Headbands", "stock": 80, "price": 10.0},
        {"name": "Gym Bags", "stock": 15, "price": 40.0},
      ],
    },
  };

  void _addItem() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Adding to specific categories requires a more complex dialog. Coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _removeItem(List<dynamic> parentList, int index) {
    setState(() {
      parentList.removeAt(index);
    });
  }

  Widget _buildCategoryTree(Map<String, dynamic> data) {
    return Column(
      children: data.entries.map((entry) {
        if (entry.value is Map<String, dynamic>) {
          return ExpansionTile(
            title: Text(
              entry.key,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: _buildCategoryTree(entry.value),
              ),
            ],
          );
        } else if (entry.value is List) {
          return ExpansionTile(
            title: Text(
              entry.key,
              style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
            ),
            children: (entry.value as List).asMap().entries.map((itemEntry) {
              int idx = itemEntry.key;
              Map<String, dynamic> item = itemEntry.value;
              return ListTile(
                title: Text(item['name']),
                subtitle: Text('Stock: ${item['stock']} | Price: \$${item['price']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removeItem(entry.value, idx),
                ),
              );
            }).toList(),
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
        title: Text("Inventory", style: AppWidget.boldTextFieledStyle()),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: _buildCategoryTree(inventory),
        ),
      ),
    );
  }
}