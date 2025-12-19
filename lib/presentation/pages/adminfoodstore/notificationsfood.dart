import 'package:flutter/material.dart';

class Notificationsfood extends StatefulWidget {
  const Notificationsfood({super.key});

  @override
  State<Notificationsfood> createState() => _NotificationsfoodState();
}

class _NotificationsfoodState extends State<Notificationsfood> {
  // Sample analytics data
  final Map<String, dynamic> stats = {
    'totalOrders': 156,
    'totalRevenue': 187500.00,
    'averageOrderValue': 1201.92,
    'newCustomers': 23,
  };

  final List<Map<String, dynamic>> topCustomers = [
    {
      'name': 'Jane Wanjiru',
      'orders': 24,
      'totalSpent': 28500.00,
      'lastOrder': '2 hours ago',
    },
    {
      'name': 'John Kamau',
      'orders': 18,
      'totalSpent': 22400.00,
      'lastOrder': '1 day ago',
    },
    {
      'name': 'Mary Akinyi',
      'orders': 15,
      'totalSpent': 18750.00,
      'lastOrder': '3 hours ago',
    },
    {
      'name': 'Peter Odhiambo',
      'orders': 12,
      'totalSpent': 15600.00,
      'lastOrder': '5 hours ago',
    },
    {
      'name': 'Sarah Njeri',
      'orders': 10,
      'totalSpent': 12800.00,
      'lastOrder': '1 day ago',
    },
  ];

  final List<Map<String, dynamic>> mostBoughtFoods = [
    {
      'name': 'Green Power Bowl',
      'unitsSold': 89,
      'revenue': 75650.00,
      'category': 'Lunch/Dinner',
    },
    {
      'name': 'Protein Breakfast Wrap',
      'unitsSold': 76,
      'revenue': 49400.00,
      'category': 'Breakfast',
    },
    {
      'name': 'Superfood Smoothie',
      'unitsSold': 64,
      'revenue': 25600.00,
      'category': 'Beverage',
    },
    {
      'name': 'Athlete\'s Lunch Box',
      'unitsSold': 52,
      'revenue': 49400.00,
      'category': 'Lunch/Dinner',
    },
    {
      'name': 'Organic Salad Bowl',
      'unitsSold': 38,
      'revenue': 26600.00,
      'category': 'Lunch/Dinner',
    },
  ];

  String selectedPeriod = 'This Month';
  final List<String> periods = ['Today', 'This Week', 'This Month', 'This Year'];

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.grey[700]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics & Stats'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.calendar_today),
            onSelected: (value) {
              setState(() {
                selectedPeriod = value;
              });
            },
            itemBuilder: (context) => periods.map((period) {
              return PopupMenuItem(
                value: period,
                child: Text(period),
              );
            }).toList(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[100],
              child: Row(
                children: [
                  const Icon(Icons.date_range, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    selectedPeriod,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Stats Cards
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Total Orders',
                          stats['totalOrders'].toString(),
                          Icons.shopping_cart,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'New Customers',
                          stats['newCustomers'].toString(),
                          Icons.person_add,
                          Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Total Revenue',
                          'KSh ${(stats['totalRevenue'] / 1000).toStringAsFixed(1)}K',
                          Icons.payments,
                          Colors.purple,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'Avg Order',
                          'KSh ${stats['averageOrderValue'].toStringAsFixed(0)}',
                          Icons.trending_up,
                          Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(thickness: 8),

            // Top Customers Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Top Customers',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('View All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...topCustomers.asMap().entries.map((entry) {
                    final index = entry.key;
                    final customer = entry.value;
                    return _buildCustomerCard(customer, index + 1);
                  }),
                ],
              ),
            ),

            const Divider(thickness: 8),

            // Most Bought Foods Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Best Selling Items',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('View All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...mostBoughtFoods.asMap().entries.map((entry) {
                    final index = entry.key;
                    final food = entry.value;
                    return _buildFoodCard(food, index + 1);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.arrow_upward, size: 12, color: Colors.green),
                    Text(
                      '12%',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
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
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard(Map<String, dynamic> customer, int rank) {
    final medalColors = [Colors.amber, Colors.grey[400]!, Colors.brown[300]!];
    final medalColor = rank <= 3 ? medalColors[rank - 1] : Colors.grey[700]!;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Stack(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[700],
              radius: 25,
              child: Text(
                customer['name'][0],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: medalColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Text(
                  '$rank',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        title: Text(
          customer['name'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.shopping_bag, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text('${customer['orders']} orders'),
                const SizedBox(width: 12),
                Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(customer['lastOrder']),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'KSh ${(customer['totalSpent'] / 1000).toStringAsFixed(1)}K',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Total Spent',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodCard(Map<String, dynamic> food, int rank) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.pink
    ];
    final color = colors[(rank - 1) % colors.length];

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              '#$rank',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        title: Text(
          food['name'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(food['category']),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.shopping_cart, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text('${food['unitsSold']} units sold'),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'KSh ${(food['revenue'] / 1000).toStringAsFixed(1)}K',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Revenue',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}