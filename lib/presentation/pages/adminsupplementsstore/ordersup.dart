import 'package:flutter/material.dart';

class Ordersup extends StatefulWidget {
  const Ordersup({super.key});

  @override
  State<Ordersup> createState() => _OrdersupState();
}

class _OrdersupState extends State<Ordersup> {
  final List<Map<String, dynamic>> orders = [
    {
      'orderId': 'ORD-2024-001',
      'customerName': 'John Kamau',
      'status': 'Pending',
      'orderDate': '2024-12-19',
      'totalAmount': 8500.0,
      'supplements': [
        {'name': 'Ultimate Whey Protein', 'quantity': 2, 'price': 3500.0},
        {'name': 'Pre-Workout Extreme', 'quantity': 1, 'price': 1500.0},
      ],
    },
    {
      'orderId': 'ORD-2024-002',
      'customerName': 'Sarah Njeri',
      'status': 'Processing',
      'orderDate': '2024-12-18',
      'totalAmount': 5200.0,
      'supplements': [
        {'name': 'Multivitamin Elite', 'quantity': 2, 'price': 2600.0},
      ],
    },
    {
      'orderId': 'ORD-2024-003',
      'customerName': 'Michael Odhiambo',
      'status': 'Shipped',
      'orderDate': '2024-12-17',
      'totalAmount': 12500.0,
      'supplements': [
        {'name': 'Ultimate Whey Protein', 'quantity': 3, 'price': 3500.0},
        {'name': 'Joint Support Complex', 'quantity': 1, 'price': 2000.0},
      ],
    },
    {
      'orderId': 'ORD-2024-004',
      'customerName': 'Grace Wanjiru',
      'status': 'Delivered',
      'orderDate': '2024-12-15',
      'totalAmount': 4500.0,
      'supplements': [
        {'name': 'Pre-Workout Extreme', 'quantity': 3, 'price': 1500.0},
      ],
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Processing':
        return Colors.blue;
      case 'Shipped':
        return Colors.purple;
      case 'Delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Order ${order['orderId']}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Customer: ${order['customerName']}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Date: ${order['orderDate']}'),
              const SizedBox(height: 8),
              Text('Status: ${order['status']}', style: TextStyle(color: _getStatusColor(order['status']))),
              const SizedBox(height: 16),
              const Text('Supplements:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...(order['supplements'] as List).map((supplement) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('${supplement['name']} x${supplement['quantity']}'),
                      ),
                      Text('KSh ${supplement['price'] * supplement['quantity']}'),
                    ],
                  ),
                );
              }),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('KSh ${order['totalAmount']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Order Timeline:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildTimeline(order['status']),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          if (order['status'] != 'Delivered')
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _updateOrderStatus(order);
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 47, 47, 49),
                foregroundColor: Colors.white,
              ),
              child: const Text('Update Status'),
            ),
        ],
      ),
    );
  }

  void _updateOrderStatus(Map<String, dynamic> order) {
    final statusFlow = ['Pending', 'Processing', 'Shipped', 'Delivered'];
    final currentIndex = statusFlow.indexOf(order['status']);
    if (currentIndex < statusFlow.length - 1) {
      setState(() {
        order['status'] = statusFlow[currentIndex + 1];
      });
    }
  }

  Widget _buildTimeline(String currentStatus) {
    final statuses = ['Pending', 'Processing', 'Shipped', 'Delivered'];
    final currentIndex = statuses.indexOf(currentStatus);

    return Column(
      children: statuses.asMap().entries.map((entry) {
        final index = entry.key;
        final status = entry.value;
        final isCompleted = index <= currentIndex;

        return Row(
          children: [
            Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted ? Colors.green : Colors.grey[300],
                  ),
                  child: isCompleted
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
                ),
                if (index < statuses.length - 1)
                  Container(
                    width: 2,
                    height: 30,
                    color: isCompleted ? Colors.green : Colors.grey[300],
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Text(
              status,
              style: TextStyle(
                fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
                color: isCompleted ? Colors.black : Colors.grey,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color.fromARGB(255, 47, 47, 49);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
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
                _buildStatCard('Total', orders.length.toString(), primaryColor),
                _buildStatCard('Pending', '${orders.where((o) => o['status'] == 'Pending').length}', Colors.orange),
                _buildStatCard('Shipped', '${orders.where((o) => o['status'] == 'Shipped').length}', Colors.purple),
                _buildStatCard('Delivered', '${orders.where((o) => o['status'] == 'Delivered').length}', Colors.green),
              ],
            ),
          ),

          // Orders List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: _getStatusColor(order['status']),
                      child: Text(
                        order['customerName'][0],
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      order['orderId'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text('Customer: ${order['customerName']}'),
                        const SizedBox(height: 4),
                        Text('Items: ${(order['supplements'] as List).length} supplements'),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getStatusColor(order['status']),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            order['status'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Text(
                      'KSh ${order['totalAmount']}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    onTap: () => _showOrderDetails(order),
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