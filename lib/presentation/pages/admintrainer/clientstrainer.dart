import 'package:flutter/material.dart';

class Clientstrainer extends StatefulWidget {
  const Clientstrainer({super.key});

  @override
  State<Clientstrainer> createState() => _ClientstrainerState();
}

class _ClientstrainerState extends State<Clientstrainer> {
  // Grey color scheme
  final Color primaryGrey = const Color(0xFF616161);
  final Color lightGrey = const Color(0xFF9E9E9E);
  final Color veryLightGrey = const Color(0xFFE0E0E0);
  final Color backgroundGrey = const Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Clients'),
        backgroundColor: primaryGrey,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Container(
        color: backgroundGrey,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header section with stats
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('Total Clients', '15', Icons.people),
                  _buildStatItem('Active', '12', Icons.check_circle, Colors.green),
                  _buildStatItem('Today', '5', Icons.today, primaryGrey),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Main navigation buttons
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  _buildMenuButton(
                    'All Clients',
                    Icons.people,
                    'View and manage all your clients',
                    () {/* Navigation will be added later */},
                  ),
                  _buildMenuButton(
                    'Workouts',
                    Icons.fitness_center,
                    'View and assign workout plans',
                    () {/* Navigation will be added later */},
                  ),
                  _buildMenuButton(
                    'Progress Tracking',
                    Icons.show_chart,
                    'Track client progress and goals',
                    () {/* Navigation will be added later */},
                  ),
                  _buildMenuButton(
                    'Schedule',
                    Icons.calendar_today,
                    'Manage training sessions',
                    () {/* Navigation will be added later */},
                  ),
                  _buildMenuButton(
                    'Nutrition Plans',
                    Icons.restaurant_menu,
                    'Manage meal plans and nutrition',
                    () {/* Navigation will be added later */},
                  ),
                  _buildMenuButton(
                    'Messaging',
                    Icons.message,
                    'Communicate with your clients',
                    () {/* Navigation will be added later */},
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Action buttons at bottom
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.person_add),
                    label: const Text('ADD CLIENT'),
                    onPressed: () {/* Navigation will be added later */},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGrey,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.bar_chart),
                    label: const Text('ANALYTICS'),
                    onPressed: () {/* Navigation will be added later */},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lightGrey,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon, [Color? color]) {
    return Column(
      children: [
        Icon(
          icon,
          size: 28,
          color: color ?? lightGrey,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: primaryGrey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: lightGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuButton(
    String title,
    IconData icon,
    String description,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: primaryGrey,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryGrey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: lightGrey,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}