import 'package:flutter/material.dart';
import 'package:tiziappp2/presentation/pages/adminnutritionist/dietmessage.dart';

class Dietclientspage extends StatefulWidget {
  const Dietclientspage({super.key});

  @override
  State<Dietclientspage> createState() => _DietclientspageState();
}

class _DietclientspageState extends State<Dietclientspage> {
  final List<Map<String, dynamic>> clients = [
    {
      'name': 'Jane Wanjiru',
      'goal': 'Weight Loss',
      'startWeight': 85.0,
      'currentWeight': 78.5,
      'targetWeight': 70.0,
      'height': 1.65, // meters
      'bmi': 28.8,
      'bodyFat': 32.5, // percentage
      'bloodSugar': 95.0, // mg/dL
      'subscriptionStatus': 'Active',
      'subscriptionEnd': '2025-03-15',
      'progress': 65,
      'lastCheckIn': '2 days ago',
      'mealPlans': [
        {
          'day': 'Monday',
          'breakfast': 'Oatmeal with berries and almonds (350 cal)',
          'lunch': 'Grilled chicken salad with olive oil (450 cal)',
          'dinner': 'Baked salmon with steamed vegetables (500 cal)',
          'snacks': 'Greek yogurt, apple (200 cal)',
          'totalCalories': 1500,
        },
        {
          'day': 'Tuesday',
          'breakfast': 'Scrambled eggs with whole grain toast (400 cal)',
          'lunch': 'Quinoa bowl with chickpeas and veggies (480 cal)',
          'dinner': 'Lean beef stir-fry with brown rice (520 cal)',
          'snacks': 'Carrot sticks with hummus (150 cal)',
          'totalCalories': 1550,
        },
        {
          'day': 'Wednesday',
          'breakfast': 'Smoothie bowl with banana and chia seeds (380 cal)',
          'lunch': 'Turkey wrap with whole wheat tortilla (420 cal)',
          'dinner': 'Grilled tilapia with sweet potato (490 cal)',
          'snacks': 'Mixed nuts (180 cal)',
          'totalCalories': 1470,
        },
      ],
    },
    {
      'name': 'John Kamau',
      'goal': 'Muscle Gain',
      'startWeight': 68.0,
      'currentWeight': 72.5,
      'targetWeight': 75.0,
      'height': 1.78,
      'bmi': 22.9,
      'bodyFat': 15.2,
      'bloodSugar': 88.0,
      'subscriptionStatus': 'Active',
      'subscriptionEnd': '2025-04-20',
      'progress': 64,
      'lastCheckIn': '1 day ago',
      'mealPlans': [
        {
          'day': 'Monday',
          'breakfast': 'Protein pancakes with peanut butter (550 cal)',
          'lunch': 'Chicken breast with rice and broccoli (700 cal)',
          'dinner': 'Steak with quinoa and asparagus (800 cal)',
          'snacks': 'Protein shake, banana (400 cal)',
          'totalCalories': 2450,
        },
        {
          'day': 'Tuesday',
          'breakfast': 'Egg white omelet with cheese and toast (500 cal)',
          'lunch': 'Tuna pasta with vegetables (750 cal)',
          'dinner': 'Grilled salmon with sweet potato (780 cal)',
          'snacks': 'Cottage cheese, almonds (350 cal)',
          'totalCalories': 2380,
        },
      ],
    },
    {
      'name': 'Mary Akinyi',
      'goal': 'Diabetes Management',
      'startWeight': 92.0,
      'currentWeight': 88.0,
      'targetWeight': 80.0,
      'height': 1.60,
      'bmi': 34.4,
      'bodyFat': 38.0,
      'bloodSugar': 142.0,
      'subscriptionStatus': 'Active',
      'subscriptionEnd': '2025-02-28',
      'progress': 33,
      'lastCheckIn': '5 days ago',
      'mealPlans': [
        {
          'day': 'Monday',
          'breakfast': 'Steel-cut oats with cinnamon (300 cal)',
          'lunch': 'Lentil soup with whole grain bread (400 cal)',
          'dinner': 'Grilled chicken with cauliflower rice (450 cal)',
          'snacks': 'Sugar-free yogurt (100 cal)',
          'totalCalories': 1250,
        },
      ],
    },
    {
      'name': 'Peter Odhiambo',
      'goal': 'Heart Health',
      'startWeight': 95.0,
      'currentWeight': 90.0,
      'targetWeight': 82.0,
      'height': 1.75,
      'bmi': 29.4,
      'bodyFat': 28.5,
      'bloodSugar': 102.0,
      'subscriptionStatus': 'Expiring Soon',
      'subscriptionEnd': '2025-01-10',
      'progress': 38,
      'lastCheckIn': '1 week ago',
      'mealPlans': [
        {
          'day': 'Monday',
          'breakfast': 'Whole grain cereal with low-fat milk (320 cal)',
          'lunch': 'Mediterranean salad with grilled fish (480 cal)',
          'dinner': 'Baked chicken with roasted vegetables (500 cal)',
          'snacks': 'Fresh fruit (120 cal)',
          'totalCalories': 1420,
        },
      ],
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Expiring Soon':
        return Colors.orange;
      case 'Expired':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showClientDetails(Map<String, dynamic> client, int clientIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClientDetailScreen(
          client: client,
          onMealPlanAdded: (newMealPlan) {
            setState(() {
              clients[clientIndex]['mealPlans'].add(newMealPlan);
            });
          },
        ),
      ),
    );
  }

  void _openMessaging(Map<String, dynamic> client) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(clientName: client['name']),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.green[700]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Clients'),
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
                _buildStatCard('Total', clients.length.toString(), Colors.green[700]!),
                _buildStatCard('Active', '${clients.where((c) => c['subscriptionStatus'] == 'Active').length}', Colors.green),
                _buildStatCard('Expiring', '${clients.where((c) => c['subscriptionStatus'] == 'Expiring Soon').length}', Colors.orange),
              ],
            ),
          ),

          // Clients List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: clients.length,
              itemBuilder: (context, index) {
                final client = clients[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: primaryColor,
                      radius: 25,
                      child: Text(
                        client['name'][0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    title: Text(
                      client['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text('Goal: ${client['goal']}'),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: client['progress'] / 100,
                                backgroundColor: Colors.grey[300],
                                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${client['progress']}%',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getStatusColor(client['subscriptionStatus']),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            client['subscriptionStatus'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.message, color: primaryColor),
                      onPressed: () => _openMessaging(client),
                      tooltip: 'Message Client',
                    ),
                    onTap: () => _showClientDetails(client, index),
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

// Client Detail Screen with Meal Plans
class ClientDetailScreen extends StatefulWidget {
  final Map<String, dynamic> client;
  final Function(Map<String, dynamic>) onMealPlanAdded;

  const ClientDetailScreen({
    super.key,
    required this.client,
    required this.onMealPlanAdded,
  });

  @override
  State<ClientDetailScreen> createState() => _ClientDetailScreenState();
}

class _ClientDetailScreenState extends State<ClientDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showAddMealPlanDialog() {
    final dayController = TextEditingController();
    final breakfastController = TextEditingController();
    final lunchController = TextEditingController();
    final dinnerController = TextEditingController();
    final snacksController = TextEditingController();
    final caloriesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Meal Plan'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: dayController,
                decoration: const InputDecoration(
                  labelText: 'Day (e.g., Thursday)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: breakfastController,
                decoration: const InputDecoration(
                  labelText: 'Breakfast',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: lunchController,
                decoration: const InputDecoration(
                  labelText: 'Lunch',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: dinnerController,
                decoration: const InputDecoration(
                  labelText: 'Dinner',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: snacksController,
                decoration: const InputDecoration(
                  labelText: 'Snacks',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: caloriesController,
                decoration: const InputDecoration(
                  labelText: 'Total Calories',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (dayController.text.isNotEmpty && caloriesController.text.isNotEmpty) {
                final newMealPlan = {
                  'day': dayController.text,
                  'breakfast': breakfastController.text,
                  'lunch': lunchController.text,
                  'dinner': dinnerController.text,
                  'snacks': snacksController.text,
                  'totalCalories': int.tryParse(caloriesController.text) ?? 0,
                };
                
                setState(() {
                  if (widget.client['mealPlans'] != null) {
                    (widget.client['mealPlans'] as List).add(newMealPlan);
                  } else {
                    widget.client['mealPlans'] = [newMealPlan];
                  }
                });
                
                widget.onMealPlanAdded(newMealPlan);
                Navigator.pop(context);
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Meal plan added successfully!'),
                    backgroundColor: Colors.green[700],
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.green[700]!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: Text(widget.client['name']),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.person), text: 'Progress'),
            Tab(icon: Icon(Icons.restaurant_menu), text: 'Meal Plans'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProgressTab(),
          _buildMealPlansTab(),
        ],
      ),
    );
  }

  Widget _buildProgressTab() {
    final Color primaryColor = Colors.green[700]!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Health Metrics Card
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.health_and_safety, color: primaryColor),
                      const SizedBox(width: 8),
                      const Text(
                        'Health Metrics',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMetricCard('BMI', widget.client['bmi'].toStringAsFixed(1), _getBMIColor(widget.client['bmi'])),
                      _buildMetricCard('Body Fat', '${widget.client['bodyFat'].toStringAsFixed(1)}%', Colors.orange),
                      _buildMetricCard('Blood Sugar', '${widget.client['bloodSugar'].toStringAsFixed(0)} mg/dL', _getBloodSugarColor(widget.client['bloodSugar'])),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildMetricInfo(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Goal Card
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.flag, color: primaryColor),
                      const SizedBox(width: 8),
                      const Text(
                        'Health Goal',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.client['goal'],
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Weight Progress Card
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.trending_down, color: primaryColor),
                      const SizedBox(width: 8),
                      const Text(
                        'Weight Progress',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildWeightCard('Start', widget.client['startWeight'], Colors.grey),
                      const Icon(Icons.arrow_forward, color: Colors.grey),
                      _buildWeightCard('Current', widget.client['currentWeight'], primaryColor),
                      const Icon(Icons.arrow_forward, color: Colors.grey),
                      _buildWeightCard('Target', widget.client['targetWeight'], Colors.blue),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: widget.client['progress'] / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    minHeight: 10,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${widget.client['progress']}% Complete',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Subscription Card
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.card_membership, color: primaryColor),
                      const SizedBox(width: 8),
                      const Text(
                        'Subscription',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Status:'),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getStatusColor(widget.client['subscriptionStatus']),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.client['subscriptionStatus'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Ends:'),
                      Text(
                        widget.client['subscriptionEnd'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Last Check-in:'),
                      Text(
                        widget.client['lastCheckIn'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealPlansTab() {
    final mealPlansRaw = widget.client['mealPlans'];
    final List<Map<String, dynamic>> mealPlans = mealPlansRaw != null 
        ? List<Map<String, dynamic>>.from(mealPlansRaw as List)
        : [];

    return Column(
      children: [
        // Add Meal Plan Button
        Container(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: _showAddMealPlanDialog,
            icon: const Icon(Icons.add),
            label: const Text('Add Meal Plan'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
            ),
          ),
        ),

        // Meal Plans List
        Expanded(
          child: mealPlans.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.restaurant_menu, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No meal plans assigned yet',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: _showAddMealPlanDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Add First Meal Plan'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: mealPlans.length,
                  itemBuilder: (context, index) {
                    final mealPlan = mealPlans[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ExpansionTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green[700],
                          child: Text(
                            mealPlan['day'][0],
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(
                          mealPlan['day'],
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Text('Total: ${mealPlan['totalCalories']} calories'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildMealItem('Breakfast', mealPlan['breakfast'], Icons.wb_sunny),
                                const Divider(),
                                _buildMealItem('Lunch', mealPlan['lunch'], Icons.lunch_dining),
                                const Divider(),
                                _buildMealItem('Dinner', mealPlan['dinner'], Icons.dinner_dining),
                                const Divider(),
                                _buildMealItem('Snacks', mealPlan['snacks'], Icons.cookie),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Total Calories:',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      Text(
                                        '${mealPlan['totalCalories']} cal',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.green[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
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

  Widget _buildMetricInfo() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, size: 16, color: Colors.blue[700]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'BMI: Normal (18.5-24.9) | Blood Sugar: Normal (70-100 mg/dL)',
              style: TextStyle(fontSize: 11, color: Colors.blue[700]),
            ),
          ),
        ],
      ),
    );
  }

  Color _getBMIColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }

  Color _getBloodSugarColor(double bloodSugar) {
    if (bloodSugar < 70) return Colors.blue;
    if (bloodSugar <= 100) return Colors.green;
    if (bloodSugar <= 125) return Colors.orange;
    return Colors.red;
  }

  Widget _buildMealItem(String mealType, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green[700], size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mealType,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightCard(String label, double weight, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          '${weight}kg',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: color,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Expiring Soon':
        return Colors.orange;
      case 'Expired':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}