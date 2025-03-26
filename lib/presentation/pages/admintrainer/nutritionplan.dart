import 'package:flutter/material.dart';

class Nutritionplan extends StatefulWidget {
  const Nutritionplan({super.key});

  @override
  State<Nutritionplan> createState() => _NutritionplanState();
}

class _NutritionplanState extends State<Nutritionplan> {
  // Grey color scheme
  final Color primaryGrey = const Color(0xFF616161);
  final Color lightGrey = const Color(0xFF9E9E9E);
  final Color veryLightGrey = const Color(0xFFE0E0E0);
  final Color backgroundGrey = const Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition Plans'),
        backgroundColor: primaryGrey,
        foregroundColor: Colors.white,
        actions: [
          // Filter button - non-reactive
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Filter nutrition plans feature'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          // Add nutrition plan button
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Show add nutrition plan dialog or navigate to add nutrition plan page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Add new nutrition plan feature'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: backgroundGrey,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search bar (non-functional, just UI)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: veryLightGrey),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: lightGrey),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search nutrition plans...',
                        hintStyle: TextStyle(color: lightGrey),
                        border: InputBorder.none,
                      ),
                      // Non-reactive, onChanged not implemented
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Filter chips - non-reactive, just UI
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All', true),
                  _buildFilterChip('Active', false),
                  _buildFilterChip('Inactive', false),
                  _buildFilterChip('New', false),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Client list
            Expanded(
              child: ListView(
                children: [
                  _buildNutritionCard(
                    'James Otuke',
                    'Premium',
                    'Active',
                    'https://randomuser.me/api/portraits/men/32.jpg',
                    ['Weight Loss', 'High Protein'],
                  ),
                  _buildNutritionCard(
                    'Sarah Kiatu',
                    'Standard',
                    'Active',
                    'https://randomuser.me/api/portraits/women/44.jpg',
                    ['Toning', 'Balanced Diet'],
                  ),
                  _buildNutritionCard(
                    'Michael Mwangi',
                    'Premium',
                    'Inactive',
                    'https://randomuser.me/api/portraits/men/55.jpg',
                    ['Muscle Building', 'Low Carb'],
                  ),
                  _buildNutritionCard(
                    'Lisa Ngeje',
                    'Standard',
                    'Active',
                    'https://randomuser.me/api/portraits/women/67.jpg',
                    ['Weight Loss', 'Vegan'],
                  ),
                  _buildNutritionCard(
                    'David Tole',
                    'Premium',
                    'Active',
                    'https://randomuser.me/api/portraits/men/22.jpg',
                    ['Muscle Building', 'Sports Nutrition'],
                  ),
                  _buildNutritionCard(
                    'Jennifer Mutembei',
                    'Standard',
                    'New',
                    'https://randomuser.me/api/portraits/women/28.jpg',
                    ['Weight Loss', 'Overall Health'],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryGrey,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add new nutrition plan feature'),
              duration: Duration(seconds: 1),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {
          // Non-reactive, just UI
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Filter by $label'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? primaryGrey : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? primaryGrey : lightGrey,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : primaryGrey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionCard(
    String name,
    String membershipType,
    String status,
    String photoUrl,
    List<String> goals,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Show nutrition details or navigate to nutrition details page
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('View $name\'s nutrition details'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Client photo
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(photoUrl),
                    backgroundColor: lightGrey,
                  ),
                  const SizedBox(width: 16),
                  // Client info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: status == 'Active'
                                    ? Colors.green.shade100
                                    : status == 'Inactive'
                                        ? Colors.red.shade100
                                        : Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                status,
                                style: TextStyle(
                                  color: status == 'Active'
                                      ? Colors.green.shade800
                                      : status == 'Inactive'
                                          ? Colors.red.shade800
                                          : Colors.blue.shade800,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          membershipType,
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryGrey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: goals
                              .map((goal) => Chip(
                                    label: Text(
                                      goal,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    backgroundColor: veryLightGrey,
                                    padding: const EdgeInsets.all(0),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 16),
              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(
                    Icons.fastfood,
                    'Meals',
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('View $name\'s meals'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  _buildActionButton(
                    Icons.show_chart,
                    'Progress',
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('View $name\'s progress'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  _buildActionButton(
                    Icons.message,
                    'Message',
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Message $name'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  _buildActionButton(
                    Icons.edit,
                    'Edit',
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Edit $name\'s nutrition plan'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon, String label, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: primaryGrey, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: primaryGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}