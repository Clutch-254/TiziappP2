import 'package:flutter/material.dart';
import 'package:tiziappp2/technicals/widgets/supportwidget.dart';

class Orderequipspage extends StatefulWidget {
  const Orderequipspage({super.key});

  @override
  State<Orderequipspage> createState() => _OrderequipspageState();
}

class _OrderequipspageState extends State<Orderequipspage> {
  // Sample orders data
  final List<Map<String, dynamic>> orders = [
    {
      'orderId': 'ORD-2024-001',
      'customer': 'Fitness First Gym',
      'items': 'Treadmill Pro X1, Dumbbells Set',
      'total': 120000,
      'status': 'Delivered',
      'date': '2024-12-10',
      'statusColor': Colors.green,
    },
    {
      'orderId': 'ORD-2024-002',
      'customer': 'Elite Training Center',
      'items': 'Power Rack Elite, Bench Press',
      'total': 77000,
      'status': 'Shipped',
      'date': '2024-12-12',
      'statusColor': Colors.blue,
    },
    {
      'orderId': 'ORD-2024-003',
      'customer': 'Home Gym Solutions',
      'items': 'Exercise Bike S200',
      'total': 28000,
      'status': 'Processing',
      'date': '2024-12-13',
      'statusColor': Colors.orange,
    },
    {
      'orderId': 'ORD-2024-004',
      'customer': 'CrossFit Zone',
      'items': 'Rowing Machine R500, Battle Ropes',
      'total': 62000,
      'status': 'Pending',
      'date': '2024-12-14',
      'statusColor': Colors.grey,
    },
  ];

  void _viewOrderDetails(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(order['orderId']),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Customer', order['customer']),
              const SizedBox(height: 8),
              _buildDetailRow('Items', order['items']),
              const SizedBox(height: 8),
              _buildDetailRow('Total', 'Ksh ${order['total']}'),
              const SizedBox(height: 8),
              _buildDetailRow('Date', order['date']),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Status: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: order['statusColor'],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      order['status'],
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
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
                _updateOrderStatus(order);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: const Text('Update Status'),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
        Expanded(child: Text(value)),
      ],
    );
  }

  void _updateOrderStatus(Map<String, dynamic> order) {
    final statuses = ['Pending', 'Processing', 'Shipped', 'Delivered'];
    String? selectedStatus = order['status'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Order Status'),
        content: StatefulBuilder(
          builder: (context, setDialogState) => DropdownButtonFormField<String>(
            value: selectedStatus,
            decoration: const InputDecoration(
              labelText: 'Status',
              border: OutlineInputBorder(),
            ),
            items: statuses.map((status) {
              return DropdownMenuItem(value: status, child: Text(status));
            }).toList(),
            onChanged: (value) {
              setDialogState(() => selectedStatus = value);
            },
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
                order['status'] = selectedStatus;
                order['statusColor'] = _getStatusColor(selectedStatus!);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Order status updated to $selectedStatus')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Delivered':
        return Colors.green;
      case 'Shipped':
        return Colors.blue;
      case 'Processing':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Equipment Orders",
          style: AppWidget.boldTextFieledStyle(),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(order['orderId'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order['customer']),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: order['statusColor'],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          order['status'],
                          style: const TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('• ${order['date']}', style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Ksh ${order['total']}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
              onTap: () => _viewOrderDetails(order),
            ),
          );
        },
      ),
    );
  }
}