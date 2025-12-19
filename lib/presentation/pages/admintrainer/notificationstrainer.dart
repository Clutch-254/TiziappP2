import 'package:flutter/material.dart';

class Notificationstrainer extends StatefulWidget {
  const Notificationstrainer({super.key});

  @override
  State<Notificationstrainer> createState() => _NotificationstrainerState();
}

class _NotificationstrainerState extends State<Notificationstrainer> {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'New Subscriber!',
      'message': 'Alice Wanjiku has just subscribed to your "Strength & Conditioning" program.',
      'time': '2 mins ago',
      'type': 'subscriber',
      'isRead': false,
    },
    {
      'title': 'Payment Received',
      'message': 'You received KSh 3,500 from Michael Otieno for the monthly training fee.',
      'time': '1 hour ago',
      'type': 'payment',
      'isRead': true,
    },
    {
      'title': 'New Subscriber!',
      'message': 'David Kamau is now following your training routines.',
      'time': '3 hours ago',
      'type': 'subscriber',
      'isRead': false,
    },
    {
      'title': 'Client Progress Update',
      'message': 'Sarah Njeri updated her weight progress: -2kg this week!',
      'time': 'Yesterday',
      'type': 'progress',
      'isRead': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Color primaryGrey = const Color(0xFF616161);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: primaryGrey,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Container(
            color: notification['isRead'] ? Colors.transparent : Colors.blue.withOpacity(0.05),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _getIconColor(notification['type']),
                child: Icon(_getIcon(notification['type']), color: Colors.white, size: 20),
              ),
              title: Text(
                notification['title'],
                style: TextStyle(
                  fontWeight: notification['isRead'] ? FontWeight.normal : FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification['message']),
                  const SizedBox(height: 4),
                  Text(
                    notification['time'],
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  notification['isRead'] = true;
                });
              },
            ),
          );
        },
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'subscriber':
        return Icons.person_add;
      case 'payment':
        return Icons.account_balance_wallet;
      case 'progress':
        return Icons.show_chart;
      default:
        return Icons.notifications;
    }
  }

  Color _getIconColor(String type) {
    switch (type) {
      case 'subscriber':
        return Colors.blue;
      case 'payment':
        return Colors.green;
      case 'progress':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}