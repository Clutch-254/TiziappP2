import 'package:flutter/material.dart';

class Inventoryfoodpage extends StatefulWidget {
  const Inventoryfoodpage({super.key});

  @override
  State<Inventoryfoodpage> createState() => _InventoryfoodpageState();
}

class _InventoryfoodpageState extends State<Inventoryfoodpage> {
  List<Map<String, dynamic>> inventory = [
    {
      'name': 'Green Power Bowl',
      'category': 'Lunch/Dinner',
      'stock': 25,
      'unit': 'servings',
      'lowStockThreshold': 10,
    },
    {
      'name': 'Protein Breakfast Wrap',
      'category': 'Breakfast',
      'stock': 8,
      'unit': 'servings',
      'lowStockThreshold': 10,
    },
    {
      'name': 'Superfood Smoothie',
      'category': 'Beverage',
      'stock': 15,
      'unit': 'servings',
      'lowStockThreshold': 10,
    },
    {
      'name': 'Athlete\'s Lunch Box',
      'category': 'Lunch/Dinner',
      'stock': 5,
      'unit': 'servings',
      'lowStockThreshold': 10,
    },
    {
      'name': 'Organic Kale',
      'category': 'Produce',
      'stock': 3,
      'unit': 'kg',
      'lowStockThreshold': 5,
    },
    {
      'name': 'Chicken Breast',
      'category': 'Protein',
      'stock': 12,
      'unit': 'kg',
      'lowStockThreshold': 8,
    },
    {
      'name': 'Quinoa',
      'category': 'Grains',
      'stock': 20,
      'unit': 'kg',
      'lowStockThreshold': 10,
    },
  ];

  bool showLowStockOnly = false;

  List<Map<String, dynamic>> get displayedInventory {
    if (showLowStockOnly) {
      return inventory.where((item) => item['stock'] < item['lowStockThreshold']).toList();
    }
    return inventory;
  }

  int get lowStockCount => inventory.where((item) => item['stock'] < item['lowStockThreshold']).length;

  bool isLowStock(Map<String, dynamic> item) {
    return item['stock'] < item['lowStockThreshold'];
  }

  Color getStockColor(Map<String, dynamic> item) {
    if (item['stock'] == 0) return Colors.red;
    if (isLowStock(item)) return Colors.orange;
    return Colors.green;
  }

  void _showAdjustStockDialog(Map<String, dynamic> item, int index) {
    final stockController = TextEditingController(text: item['stock'].toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Adjust Stock: ${item['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text('Current Stock: ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${item['stock']} ${item['unit']}'),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: stockController,
              decoration: InputDecoration(
                labelText: 'New Stock Quantity',
                border: const OutlineInputBorder(),
                suffixText: item['unit'],
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    final currentStock = int.tryParse(stockController.text) ?? item['stock'];
                    stockController.text = (currentStock + 10).toString();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('+10'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    final currentStock = int.tryParse(stockController.text) ?? item['stock'];
                    stockController.text = (currentStock - 5).toString();
                  },
                  icon: const Icon(Icons.remove),
                  label: const Text('-5'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
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
              final newStock = int.tryParse(stockController.text);
              if (newStock != null && newStock >= 0) {
                setState(() {
                  inventory[index]['stock'] = newStock;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Stock updated for ${item['name']}'),
                    backgroundColor: Colors.grey[700],
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a valid number')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[700],
              foregroundColor: Colors.white,
            ),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showStockHistory(Map<String, dynamic> item) {
    // Sample stock history
    final history = [
      {'date': '2025-12-18', 'action': 'Restocked', 'quantity': '+20', 'by': 'Admin'},
      {'date': '2025-12-17', 'action': 'Sold', 'quantity': '-15', 'by': 'System'},
      {'date': '2025-12-16', 'action': 'Restocked', 'quantity': '+30', 'by': 'Admin'},
      {'date': '2025-12-15', 'action': 'Sold', 'quantity': '-10', 'by': 'System'},
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Stock History: ${item['name']}'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: history.length,
            itemBuilder: (context, index) {
              final record = history[index];
              final isPositive = record['quantity'].toString().startsWith('+');
              
              return ListTile(
                leading: Icon(
                  isPositive ? Icons.add_circle : Icons.remove_circle,
                  color: isPositive ? Colors.green : Colors.red,
                ),
                title: Text(record['action']!),
                subtitle: Text('${record['date']} • By ${record['by']}'),
                trailing: Text(
                  record['quantity']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isPositive ? Colors.green : Colors.red,
                  ),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.grey[700]!;
    final items = displayedInventory;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(showLowStockOnly ? Icons.filter_alt : Icons.filter_alt_outlined),
            onPressed: () {
              setState(() {
                showLowStockOnly = !showLowStockOnly;
              });
            },
            tooltip: 'Show Low Stock Only',
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats Header
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard('Total Items', inventory.length.toString(), Colors.blue),
                _buildStatCard('Low Stock', lowStockCount.toString(), Colors.orange),
                _buildStatCard('Out of Stock', '${inventory.where((i) => i['stock'] == 0).length}', Colors.red),
              ],
            ),
          ),

          // Low Stock Alert Banner
          if (lowStockCount > 0 && !showLowStockOnly)
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.orange[50],
              child: Row(
                children: [
                  const Icon(Icons.warning, color: Colors.orange),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '$lowStockCount item${lowStockCount > 1 ? 's' : ''} running low on stock',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showLowStockOnly = true;
                      });
                    },
                    child: const Text('View'),
                  ),
                ],
              ),
            ),

          // Inventory List
          Expanded(
            child: items.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inventory_2, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'No items to display',
                          style: TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    itemBuilder: (context, displayIndex) {
                      final actualIndex = inventory.indexOf(items[displayIndex]);
                      final item = items[displayIndex];
                      final stockColor = getStockColor(item);
                      
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: stockColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.inventory_2,
                              color: stockColor,
                              size: 30,
                            ),
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item['name'],
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              if (isLowStock(item))
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'LOW',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(item['category']),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.inventory, size: 16, color: Colors.grey[600]),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Stock: ',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Text(
                                    '${item['stock']} ${item['unit']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: stockColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.add_circle, color: Colors.green),
                                onPressed: () => _showAdjustStockDialog(item, actualIndex),
                                tooltip: 'Restock',
                              ),
                            ],
                          ),
                          onTap: () => _showStockHistory(item),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}