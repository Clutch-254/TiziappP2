import 'package:flutter/material.dart';

class Dietnotification extends StatefulWidget {
  const Dietnotification({super.key});

  @override
  State<Dietnotification> createState() => _DietnotificationState();
}

class _DietnotificationState extends State<Dietnotification> {
  final List<Map<String, dynamic>> notifications = [
    {
      'type': 'new_subscription',
      'clientName': 'Alice Muthoni',
      'message': 'subscribed to your nutrition program',
      'timestamp': '5 minutes ago',
      'icon': Icons.person_add,
      'color': Colors.green,
    },
    {
      'type': 'new_subscription',
      'clientName': 'David Otieno',
      'message': 'subscribed to your nutrition program',
      'timestamp': '2 hours ago',
      'icon': Icons.person_add,
      'color': Colors.green,
    },
    {
      'type': 'message',
      'clientName': 'Jane Wanjiru',
      'message': 'sent you a message',
      'timestamp': '3 hours ago',
      'icon': Icons.message,
      'color': Colors.blue,
    },
    {
      'type': 'milestone',
      'clientName': 'John Kamau',
      'message': 'achieved their weight goal!',
      'timestamp': '1 day ago',
      'icon': Icons.emoji_events,
      'color': Colors.amber,
    },
    {
      'type': 'new_subscription',
      'clientName': 'Grace Njeri',
      'message': 'subscribed to your nutrition program',
      'timestamp': '2 days ago',
      'icon': Icons.person_add,
      'color': Colors.green,
    },
    {
      'type': 'renewal',
      'clientName': 'Peter Odhiambo',
      'message': 'renewed their subscription',
      'timestamp': '3 days ago',
      'icon': Icons.refresh,
      'color': Colors.purple,
    },
  ];

  int get newSubscriptionsCount =>
      notifications.where((n) => n['type'] == 'new_subscription').length;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.green[700]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Stats Header
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.green[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard(
                  'Total',
                  notifications.length.toString(),
                  Colors.green[700]!,
                ),
                _buildStatCard(
                  'New Clients',
                  newSubscriptionsCount.toString(),
                  Colors.green,
                ),
                _buildStatCard(
                  'Today',
                  '${notifications.where((n) => n['timestamp'].contains('minutes') || n['timestamp'].contains('hours')).length}',
                  Colors.blue,
                ),
              ],
            ),
          ),

          // Notifications List
          Expanded(
            child: notifications.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_none, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'No notifications yet',
                          style: TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: notification['color'].withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            notification['icon'],
                            color: notification['color'],
                          ),
                        ),
                        title: RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.black, fontSize: 14),
                            children: [
                              TextSpan(
                                text: notification['clientName'],
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: ' ${notification['message']}'),
                            ],
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            notification['timestamp'],
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                        trailing: notification['type'] == 'new_subscription'
                            ? Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'NEW',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : null,
                        onTap: () {
                          // Handle notification tap
                        },
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