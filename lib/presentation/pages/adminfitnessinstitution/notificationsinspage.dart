import 'package:flutter/material.dart';

class Notificationsinspage extends StatefulWidget {
  const Notificationsinspage({super.key});

  @override
  State<Notificationsinspage> createState() => _NotificationsinspageState();
}

class _NotificationsinspageState extends State<Notificationsinspage> {
  // Dummy data for subscription requests
  final List<Map<String, dynamic>> _requests = [
    {
      'id': '1',
      'name': 'Brian Kipkorir',
      'type': 'Monthly Subscription',
      'date': 'Today, 10:30 AM',
      'image': null,
    },
    {
      'id': '2',
      'name': 'Alice Muthoni',
      'type': 'Annual Membership',
      'date': 'Yesterday, 4:15 PM',
      'image': null,
    },
    {
      'id': '3',
      'name': 'David Kamau',
      'type': 'Yoga Class Package',
      'date': 'Yesterday, 2:00 PM',
      'image': null,
    },
    {
      'id': '4',
      'name': 'Grace Wanjiru',
      'type': 'Personal Training',
      'date': '12 Dec, 9:00 AM',
      'image': null,
    },
  ];

  void _handleRequest(String id, bool approved) {
    // In a real app, this would make an API call
    setState(() {
      _requests.removeWhere((request) => request['id'] == id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(approved ? 'Subscription Approved' : 'Subscription Declined'),
        backgroundColor: approved ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: _requests.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_off_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No new notifications',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _requests.length,
              itemBuilder: (context, index) {
                final request = _requests[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              radius: 24,
                              child: Text(
                                request['name'][0],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    request['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    request['date'],
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Requested: ${request['type']}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => _handleRequest(request['id'], false),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.red,
                                  side: const BorderSide(color: Colors.red),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: const Text('Decline'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _handleRequest(request['id'], true),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: const Text('Approve'),
                              ),
                            ),
                          ],
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