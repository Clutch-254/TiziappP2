import 'package:flutter/material.dart';
import 'package:tiziappp2/technicals/widgets/supportwidget.dart';

class Inventoryequippage extends StatefulWidget {
  const Inventoryequippage({super.key});

  @override
  State<Inventoryequippage> createState() => _InventoryequippageState();
}

class _InventoryequippageState extends State<Inventoryequippage> {
  // Sample equipment inventory
  List<Map<String, dynamic>> equipment = [
    {'name': 'Treadmill Pro X1', 'price': 85000, 'stock': 12, 'category': 'Cardio'},
    {'name': 'Power Rack Elite', 'price': 45000, 'stock': 8, 'category': 'Strength'},
    {'name': 'Dumbbells Set (5-50kg)', 'price': 35000, 'stock': 15, 'category': 'Strength'},
    {'name': 'Exercise Bike S200', 'price': 28000, 'stock': 20, 'category': 'Cardio'},
    {'name': 'Rowing Machine R500', 'price': 55000, 'stock': 6, 'category': 'Cardio'},
    {'name': 'Bench Press Station', 'price': 32000, 'stock': 10, 'category': 'Strength'},
  ];

  void _addEquipment() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final stockController = TextEditingController();
    String selectedCategory = 'Strength';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Equipment'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Equipment Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'Price (Ksh)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: stockController,
                decoration: const InputDecoration(
                  labelText: 'Stock Quantity',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: ['Strength', 'Cardio', 'Functional', 'Accessories']
                    .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (value) => selectedCategory = value!,
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
              if (nameController.text.isNotEmpty &&
                  priceController.text.isNotEmpty &&
                  stockController.text.isNotEmpty) {
                setState(() {
                  equipment.add({
                    'name': nameController.text,
                    'price': int.parse(priceController.text),
                    'stock': int.parse(stockController.text),
                    'category': selectedCategory,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Equipment added successfully!')),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _removeEquipment(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Equipment'),
        content: Text('Are you sure you want to remove ${equipment[index]['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                equipment.removeAt(index);
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
      body: equipment.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text('No equipment in inventory', style: AppWidget.boldTextFieledStyle()),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: _addEquipment,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Equipment'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: equipment.length,
              itemBuilder: (context, index) {
                final item = equipment[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(
                        item['category'] == 'Cardio' ? Icons.directions_run : Icons.fitness_center,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${item['category']} • Stock: ${item['stock']} units'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Ksh ${item['price']}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => _removeEquipment(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}