import 'package:flutter/material.dart';
import 'package:tiziappp2/technicals/widgets/supportwidget.dart';

class Inventoryequippage extends StatefulWidget {
  const Inventoryequippage({super.key});

  @override
  State<Inventoryequippage> createState() => _InventoryequippageState();
}

class _InventoryequippageState extends State<Inventoryequippage> {
  // Hierarchical equipment inventory
  Map<String, dynamic> inventory = {
    'Free Weights': {
      'Kettlebells': [
        {'name': '4kg Kettlebell', 'price': 1500, 'stock': 20},
        {'name': '8kg Kettlebell', 'price': 3000, 'stock': 15},
        {'name': '12kg Kettlebell', 'price': 4500, 'stock': 10},
      ],
      'Dumbbells': {
        'Fixed Weights': [
          {'name': '4kg Dumbbell', 'price': 1200, 'stock': 20},
          {'name': '6kg Dumbbell', 'price': 1800, 'stock': 18},
          {'name': '8kg Dumbbell', 'price': 2400, 'stock': 15},
          {'name': '10kg Dumbbell', 'price': 3000, 'stock': 12},
          {'name': '12kg Dumbbell', 'price': 3600, 'stock': 10},
          {'name': '14kg Dumbbell', 'price': 4200, 'stock': 8},
          {'name': '16kg Dumbbell', 'price': 4800, 'stock': 6},
          {'name': '18kg Dumbbell', 'price': 5400, 'stock': 5},
          {'name': '20kg Dumbbell', 'price': 6000, 'stock': 4},
        ],
        'Adjustable Weights': {
          'Free Bars': [
            {'name': 'Standard Dumbbell Bar', 'price': 1500, 'stock': 30},
            {'name': 'Olympic Dumbbell Handle', 'price': 3500, 'stock': 10},
          ],
          'Weights': [
            {'name': '1kg Plate', 'price': 300, 'stock': 50},
            {'name': '2kg Plate', 'price': 600, 'stock': 40},
            {'name': '3kg Plate', 'price': 900, 'stock': 30},
            {'name': '4kg Plate', 'price': 1200, 'stock': 25},
            {'name': '5kg Plate', 'price': 1500, 'stock': 20},
            {'name': '10kg Plate', 'price': 3000, 'stock': 15},
            {'name': '15kg Plate', 'price': 4500, 'stock': 10},
            {'name': '20kg Plate', 'price': 6000, 'stock': 5},
          ]
        }
      },
      'Barbells': {
        'Bars': [
          {'name': 'EZ Bar', 'price': 4500, 'stock': 10},
          {'name': 'Olympic Bar (20kg)', 'price': 15000, 'stock': 5},
          {'name': 'Standard Bar', 'price': 3500, 'stock': 15},
          {'name': 'Trap Bar', 'price': 8000, 'stock': 3},
        ],
        'Weights': [
          {'name': '2.5kg Olympic Plate', 'price': 1000, 'stock': 40},
          {'name': '5kg Olympic Plate', 'price': 2000, 'stock': 30},
          {'name': '10kg Olympic Plate', 'price': 4000, 'stock': 20},
          {'name': '15kg Olympic Plate', 'price': 6000, 'stock': 15},
          {'name': '20kg Olympic Plate', 'price': 8000, 'stock': 10},
          {'name': '25kg Olympic Plate', 'price': 10000, 'stock': 5},
        ]
      }
    },
    'Machines': {
      'Arms': [
        {'name': 'Tricep Pull Down Machine', 'price': 85000, 'stock': 2},
        {'name': 'Preacher Curl Set', 'price': 45000, 'stock': 3},
        {'name': 'Bicep Curl Machine', 'price': 75000, 'stock': 2},
      ],
      'Quads': [
        {'name': 'Squat Rack', 'price': 65000, 'stock': 4},
        {'name': 'Leg Extension Machine', 'price': 95000, 'stock': 2},
        {'name': 'Leg Press Machine', 'price': 120000, 'stock': 1},
        {'name': 'Hack Squat Machine', 'price': 110000, 'stock': 1},
      ],
      'Hamstrings': [
        {'name': 'Lying Hamstring Curl', 'price': 90000, 'stock': 2},
        {'name': 'Seated Leg Curl', 'price': 95000, 'stock': 2},
      ],
      'Back': [
        {'name': 'Lat Pull Down Machine', 'price': 85000, 'stock': 3},
        {'name': 'Seated Row Machine', 'price': 80000, 'stock': 2},
        {'name': 'T-Bar Row', 'price': 45000, 'stock': 3},
      ],
      'Shoulders': [
        {'name': 'Shoulder Press Machine', 'price': 90000, 'stock': 2},
        {'name': 'Lateral Raise Machine', 'price': 85000, 'stock': 1},
      ],
      'Abs': [
        {'name': 'Ab Crunch Machine', 'price': 70000, 'stock': 2},
        {'name': 'Decline Bench', 'price': 25000, 'stock': 5},
      ],
      'Chest': [
        {'name': 'Chest Press Machine', 'price': 95000, 'stock': 2},
        {'name': 'Pec Fly Machine', 'price': 85000, 'stock': 2},
      ]
    },
    'Cardio': {
      'Treadmills': [
        {'name': 'Commercial Treadmill T1', 'price': 150000, 'stock': 5},
        {'name': 'Home Treadmill T2', 'price': 85000, 'stock': 10},
      ],
      'Bikes': [
        {'name': 'Spin Bike Pro', 'price': 45000, 'stock': 8},
        {'name': 'Recumbent Bike', 'price': 55000, 'stock': 4},
      ],
      'Ellipticals': [
        {'name': 'Elliptical Trainer E1', 'price': 95000, 'stock': 3},
      ],
      'Rowers': [
        {'name': 'Air Rower R1', 'price': 75000, 'stock': 5},
      ]
    }
  };

  void _addEquipment() {
    // This is a simplified add function for demonstration. 
    // A full implementation would require a multi-step dialog or cascading dropdowns 
    // to select the correct nested category.
    // For now, we'll just show a message that this feature would be complex to implement fully inline.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('To add items, please navigate to the specific category in the list and tap "Add Item" (Feature to be implemented)')),
    );
  }

  void _removeEquipment(List<dynamic> list, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Equipment'),
        content: Text('Are you sure you want to remove ${list[index]['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                list.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Equipment removed')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  // Recursive function to build the category tree
  Widget _buildCategoryTree(Map<String, dynamic> data, [String prefix = '']) {
    return Column(
      children: data.entries.map((entry) {
        if (entry.value is Map<String, dynamic>) {
          // It's a category or subcategory
          return ExpansionTile(
            title: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold)),
            children: [_buildCategoryTree(entry.value, '$prefix${entry.key} > ')],
          );
        } else if (entry.value is List) {
          // It's a list of items (leaf node)
          return ExpansionTile(
            title: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w600)),
            children: (entry.value as List).asMap().entries.map((itemEntry) {
              int index = itemEntry.key;
              Map<String, dynamic> item = itemEntry.value;
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 16,
                  child: Text(
                    item['name'][0],
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                title: Text(item['name']),
                subtitle: Text('Stock: ${item['stock']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Ksh ${item['price']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                      onPressed: () => _removeEquipment(entry.value, index),
                    ),
                  ],
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
        title: Text(
          "Equipment Inventory",
          style: AppWidget.boldTextFieledStyle(),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: _addEquipment,
            tooltip: 'Add Equipment',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildCategoryTree(inventory),
        ),
      ),
    );
  }
}