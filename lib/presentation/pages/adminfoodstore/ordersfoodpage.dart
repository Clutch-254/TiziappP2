import 'package:flutter/material.dart';

class Ordersfoodpage extends StatefulWidget {
  const Ordersfoodpage({super.key});

  @override
  State<Ordersfoodpage> createState() => _OrdersfoodpageState();
}

class _OrdersfoodpageState extends State<Ordersfoodpage> {
  List<Map<String, dynamic>> orders = [
    {
      'id': 'ORD001',
      'customerName': 'Jane Wanjiru',
      'items': ['Green Power Bowl', 'Superfood Smoothie'],
      'total': 1250.00,
      'status': 'Pending',
      'timestamp': '10:15 AM',
      'address': 'Kilimani, Nairobi',
      'phone': '+254 712 345 678',
    },
    {
      'id': 'ORD002',
      'customerName': 'John Kamau',
      'items': ['Protein Breakfast Wrap', 'Athlete\'s Lunch Box'],
      'total': 1800.00,
      'status': 'Preparing',
      'timestamp': '9:45 AM',
      'address': 'Westlands, Nairobi',
      'phone': '+254 723 456 789',
    },
    {
      'id': 'ORD003',
      'customerName': 'Mary Akinyi',
      'items': ['Green Power Bowl'],
      'total': 850.00,
      'status': 'Out for Delivery',
      'timestamp': '9:00 AM',
      'address': 'Parklands, Nairobi',
      'phone': '+254 734 567 890',
    },
    {
      'id': 'ORD004',
      'customerName': 'Peter Odhiambo',
      'items': ['Superfood Smoothie', 'Protein Breakfast Wrap'],
      'total': 950.00,
      'status': 'Delivered',
      'timestamp': '8:30 AM',
      'address': 'Lavington, Nairobi',
      'phone': '+254 745 678 901',
    },
  ];

  int get pendingOrdersCount => orders.where((order) => order['status'] == 'Pending').length;

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Preparing':
        return Colors.blue;
      case 'Out for Delivery':
        return Colors.purple;
      case 'Delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Pending':
        return Icons.pending;
      case 'Preparing':
        return Icons.restaurant;
      case 'Out for Delivery':
        return Icons.delivery_dining;
      case 'Delivered':
        return Icons.check_circle;
      default:
        return Icons.info;
    }
  }

  void _updateOrderStatus(int index, String newStatus) {
    setState(() {
      orders[index]['status'] = newStatus;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order ${orders[index]['id']} updated to $newStatus'),
        backgroundColor: Colors.grey[700],
      ),
    );
  }

  void _showOrderDetails(Map<String, dynamic> order, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(_getStatusIcon(order['status']), color: _getStatusColor(order['status'])),
            const SizedBox(width: 8),
            Text('Order ${order['id']}'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow(Icons.person, 'Customer', order['customerName']),
              const SizedBox(height: 12),
              _buildDetailRow(Icons.phone, 'Phone', order['phone']),
              const SizedBox(height: 12),
              _buildDetailRow(Icons.location_on, 'Address', order['address']),
              const SizedBox(height: 12),
              _buildDetailRow(Icons.access_time, 'Time', order['timestamp']),
              const SizedBox(height: 12),
              const Text(
                'Items:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 4),
              ...List.generate(
                (order['items'] as List).length,
                (i) => Padding(
                  padding: const EdgeInsets.only(left: 16, top: 4),
                  child: Text('• ${order['items'][i]}'),
                ),
              ),
              const SizedBox(height: 12),
              _buildDetailRow(
                Icons.payments,
                'Total',
                'KSh ${order['total'].toStringAsFixed(2)}',
              ),
              const SizedBox(height: 16),
              
              // Status Timeline
              const Text(
                'Order Status:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 12),
              _buildStatusTimeline(order['status']),
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
                Navigator.pop(context);
                _showUpdateStatusDialog(order, index);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700],
                foregroundColor: Colors.white,
              ),
              child: const Text('Update Status'),
            ),
          if (order['status'] == 'Delivered')
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showReviewDialog(order);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700],
                foregroundColor: Colors.white,
              ),
              child: const Text('View Review'),
            ),
        ],
      ),
    );
  }

  void _showUpdateStatusDialog(Map<String, dynamic> order, int index) {
    final statuses = ['Pending', 'Preparing', 'Out for Delivery', 'Delivered'];
    final currentIndex = statuses.indexOf(order['status']);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Order Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: statuses.asMap().entries.map((entry) {
            final status = entry.value;
            final statusIndex = entry.key;
            final isEnabled = statusIndex > currentIndex;
            
            return ListTile(
              leading: Icon(
                _getStatusIcon(status),
                color: isEnabled ? _getStatusColor(status) : Colors.grey,
              ),
              title: Text(
                status,
                style: TextStyle(
                  color: isEnabled ? Colors.black : Colors.grey,
                  fontWeight: statusIndex == currentIndex ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              trailing: statusIndex == currentIndex
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : null,
              enabled: isEnabled,
              onTap: isEnabled
                  ? () {
                      Navigator.pop(context);
                      _updateOrderStatus(index, status);
                    }
                  : null,
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showReviewDialog(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Customer Review'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Rating: ', style: TextStyle(fontWeight: FontWeight.bold)),
                ...List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 20)),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Review:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Excellent food quality! The delivery was fast and the packaging was great. Will definitely order again!',
              style: TextStyle(fontSize: 14),
            ),
          ],
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

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.grey[700]),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusTimeline(String currentStatus) {
    final statuses = ['Pending', 'Preparing', 'Out for Delivery', 'Delivered'];
    final currentIndex = statuses.indexOf(currentStatus);

    return Column(
      children: statuses.asMap().entries.map((entry) {
        final index = entry.key;
        final status = entry.value;
        final isCompleted = index <= currentIndex;
        final isLast = index == statuses.length - 1;

        return Row(
          children: [
            Column(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted ? _getStatusColor(status) : Colors.grey[300],
                  ),
                  child: Icon(
                    _getStatusIcon(status),
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 30,
                    color: isCompleted ? Colors.grey[700] : Colors.grey[300],
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 30),
                child: Text(
                  status,
                  style: TextStyle(
                    fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
                    color: isCompleted ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.grey[700]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              if (pendingOrdersCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$pendingOrdersCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
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
                _buildStatCard('Pending', pendingOrdersCount.toString(), Colors.orange),
                _buildStatCard('Preparing', '${orders.where((o) => o['status'] == 'Preparing').length}', Colors.blue),
                _buildStatCard('Delivering', '${orders.where((o) => o['status'] == 'Out for Delivery').length}', Colors.purple),
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
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: _getStatusColor(order['status']).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getStatusIcon(order['status']),
                        color: _getStatusColor(order['status']),
                      ),
                    ),
                    title: Text(
                      order['id'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(order['customerName']),
                        const SizedBox(height: 4),
                        Text(
                          'KSh ${order['total'].toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                        const SizedBox(height: 4),
                        Text(
                          order['timestamp'],
                          style: const TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                    onTap: () => _showOrderDetails(order, index),
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