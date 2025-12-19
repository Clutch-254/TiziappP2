import 'package:flutter/material.dart';
import 'package:tiziappp2/technicals/widgets/supportwidget.dart';

class Clientsinspage extends StatefulWidget {
  const Clientsinspage({super.key});

  @override
  State<Clientsinspage> createState() => _ClientsinspageState();
}

class _ClientsinspageState extends State<Clientsinspage> {
  final List<Map<String, dynamic>> clients = [
    {
      "name": "Wanjiku Mwangi",
      "subscriptionEnd": "2024-01-15",
      "type": "Premium Monthly",
      "attendance": 12,
      "image": "assets/images/user1.png" // Placeholder
    },
    {
      "name": "Kevin Omondi",
      "subscriptionEnd": "2023-12-30",
      "type": "Standard Monthly",
      "attendance": 8,
      "image": "assets/images/user2.png"
    },
    {
      "name": "Brian Kamau",
      "subscriptionEnd": "2024-06-20",
      "type": "Annual Gold",
      "attendance": 45,
      "image": "assets/images/user3.png"
    },
    {
      "name": "Mercy Adhiambo",
      "subscriptionEnd": "2023-11-28",
      "type": "Basic Weekly",
      "attendance": 3,
      "image": "assets/images/user4.png"
    },
  ];

  void _showClientDetails(Map<String, dynamic> client) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              child: Text(client['name'][0], style: const TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(client['name'], style: const TextStyle(fontSize: 18))),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(Icons.calendar_today, "Subscription Ends:", client['subscriptionEnd']),
            const SizedBox(height: 10),
            _buildDetailRow(Icons.card_membership, "Type:", client['type']),
            const SizedBox(height: 10),
            _buildDetailRow(Icons.fitness_center, "Days Attended:", "${client['attendance']} days"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[700]),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subscribed Clients", style: AppWidget.boldTextFieledStyle()),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subscription Title Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Text(
              'Subscriptions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
          // Client List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: clients.length,
              itemBuilder: (context, index) {
                final client = clients[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 25,
                      child: Text(
                        client['name'][0],
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    title: Text(client['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Text(client['type'], style: TextStyle(color: Colors.grey[600])),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    onTap: () => _showClientDetails(client),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}