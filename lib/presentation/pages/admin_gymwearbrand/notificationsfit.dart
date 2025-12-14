import 'package:flutter/material.dart';
import 'package:tiziappp2/technicals/widgets/supportwidget.dart';

class Notificationsfit extends StatefulWidget {
  const Notificationsfit({super.key});

  @override
  State<Notificationsfit> createState() => _NotificationsfitState();
}

class _NotificationsfitState extends State<Notificationsfit> {
  // Sample orders data
  final List<Map<String, dynamic>> orders = [
    {
      'orderId': 'ORD-FIT-001',
      'customer': 'John Doe',
      'items': '2x Performance Tee, 1x Joggers',
      'total': 9500,
      'status': 'Pending',
      'date': '2023-10-25',
      'statusColor': Colors.orange,
    },
    {
      'orderId': 'ORD-FIT-002',
      'customer': 'Jane Smith',
      'items': '1x High Impact Bra, 1x Leggings',
      'total': 8500,
      'status': 'Shipped',
      'date': '2023-10-24',
      'statusColor': Colors.blue,
    },
    {
      'orderId': 'ORD-FIT-003',
      'customer': 'Mike Johnson',
      'items': '1x Running Shoes',
      'total': 12000,
      'status': 'Delivered',
      'date': '2023-10-22',
      'statusColor': Colors.green,
    },
    {
      'orderId': 'ORD-FIT-004',
      'customer': 'Sarah Connor',
      'items': '3x Yoga Mats, 2x Resistance Bands',
      'total': 4500,
      'status': 'Processing',
      'date': '2023-10-26',
      'statusColor': Colors.purple,
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
              const SizedBox(height: 16),
              const Text('Tracking Status:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildTrackingStepper(order['status']),
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
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
              child: const Text('Update Status'),
            ),
        ],
      ),
    );
  }

  Widget _buildTrackingStepper(String currentStatus) {
    final steps = ['Pending', 'Processing', 'Shipped', 'Delivered'];
    int currentStepIndex = steps.indexOf(currentStatus);
    if (currentStepIndex == -1) currentStepIndex = 0;

    return Column(
      children: steps.asMap().entries.map((entry) {
        int index = entry.key;
        String title = entry.value;
        bool isActive = index <= currentStepIndex;
        bool isLast = index == steps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive ? Colors.black : Colors.grey[300],
                    border: Border.all(color: isActive ? Colors.black : Colors.grey),
                  ),
                  child: isActive
                      ? const Icon(Icons.check, size: 12, color: Colors.white)
                      : null,
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 30,
                    color: index < currentStepIndex ? Colors.black : Colors.grey[300],
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? Colors.black : Colors.grey,
              ),
            ),
          ],
        );
      }).toList(),
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
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
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
        return Colors.purple;
      case 'Pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders & Tracking", style: AppWidget.boldTextFieledStyle()),
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