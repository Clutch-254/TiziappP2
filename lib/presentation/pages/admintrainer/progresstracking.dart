import 'package:flutter/material.dart';

class Progresstracking extends StatefulWidget {
  const Progresstracking({super.key});

  @override
  State createState() => _ProgresstrackingState();
}

class _ProgresstrackingState extends State<Progresstracking> {
  // Grey color scheme
  final Color primaryGrey = const Color(0xFF616161);
  final Color lightGrey = const Color(0xFF9E9E9E);
  final Color veryLightGrey = const Color(0xFFE0E0E0);
  final Color backgroundGrey = const Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Tracking'),
        backgroundColor: primaryGrey,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Client info panel
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Client profile header
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: const NetworkImage(
                          'https://randomuser.me/api/portraits/men/32.jpg',
                        ),
                        backgroundColor: lightGrey,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'James Otuke',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Premium Member',
                            style: TextStyle(
                              fontSize: 14,
                              color: lightGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Summary stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryCard('Progress', '75%', Icons.trending_up, Colors.green),
                      _buildSummaryCard('Current', '82.5 kg', Icons.monitor_weight, Colors.blue),
                      _buildSummaryCard('Goal', '75 kg', Icons.flag, Colors.orange),
                    ],
                  ),
                ],
              ),
            ),
            
            const Divider(height: 1),
            
            // Weight progress section
            Padding(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Weight Progress',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Weight chart placeholder
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: veryLightGrey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.show_chart,
                            size: 48,
                            color: lightGrey,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Weight Progress Chart',
                            style: TextStyle(
                              color: lightGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Weight history
                  const Text(
                    'Recent Measurements',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  _buildHistoryListItem(
                    date: 'Today',
                    value: '82.5 kg',
                    change: '-0.3 kg',
                    isPositive: false,
                  ),
                  
                  _buildHistoryListItem(
                    date: 'Apr 25, 2025',
                    value: '82.8 kg',
                    change: '-0.2 kg',
                    isPositive: false,
                  ),
                  
                  _buildHistoryListItem(
                    date: 'Apr 20, 2025',
                    value: '83.0 kg',
                    change: '+0.4 kg',
                    isPositive: true,
                  ),
                  
                  _buildHistoryListItem(
                    date: 'Apr 15, 2025',
                    value: '82.6 kg',
                    change: '-0.5 kg',
                    isPositive: false,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Body composition section
            Padding(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Body Composition',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Body fat and muscle mass gauges
                  Row(
                    children: [
                      Expanded(
                        child: _buildCircleProgress(
                          'Body Fat',
                          '18.3%',
                          '-0.5%',
                          Colors.orange,
                          0.72,
                        ),
                      ),
                      Expanded(
                        child: _buildCircleProgress(
                          'Muscle Mass',
                          '42.1%',
                          '+0.3%',
                          Colors.blue,
                          0.65,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Body measurements table
                  const Text(
                    'Body Measurements',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  _buildMeasurementRow('Chest', '105 cm', '-2 cm'),
                  _buildMeasurementRow('Waist', '88 cm', '-3 cm'),
                  _buildMeasurementRow('Hips', '98 cm', '-1 cm'),
                  _buildMeasurementRow('Arms', '36 cm', '+1 cm'),
                  _buildMeasurementRow('Thighs', '58 cm', '-2 cm'),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Workout progress section
            Padding(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Workout Progress',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Workout completion stats
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          title: 'Workouts This Month',
                          value: '16/20',
                          icon: Icons.fitness_center,
                          color: Colors.purple,
                        ),
                      ),
                      Expanded(
                        child: _buildStatCard(
                          title: 'Current Streak',
                          value: '5 days',
                          icon: Icons.local_fire_department,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Workout calendar
                  const Text(
                    'Recent Activity',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Calendar placeholder
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: veryLightGrey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCalendarDay('M', 22, true),
                        _buildCalendarDay('T', 23, true),
                        _buildCalendarDay('W', 24, true),
                        _buildCalendarDay('T', 25, true),
                        _buildCalendarDay('F', 26, true),
                        _buildCalendarDay('S', 27, false),
                        _buildCalendarDay('S', 28, false),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Strength progress
                  const Text(
                    'Strength Progress',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  _buildStrengthProgressRow('Bench Press', '80 kg', '+5 kg'),
                  _buildStrengthProgressRow('Squats', '120 kg', '+10 kg'),
                  _buildStrengthProgressRow('Deadlift', '140 kg', '+15 kg'),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Nutrition section
            Padding(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Nutrition Progress',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Daily Average',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Last 30 days',
                        style: TextStyle(
                          fontSize: 14,
                          color: lightGrey,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Calories and macros stats
                  Row(
                    children: [
                      Expanded(
                        child: _buildNutritionStat(
                          label: 'Calories',
                          value: '2,150',
                          target: '2,200',
                          color: Colors.green,
                        ),
                      ),
                      Expanded(
                        child: _buildNutritionStat(
                          label: 'Protein',
                          value: '185g',
                          target: '180g',
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildNutritionStat(
                          label: 'Carbs',
                          value: '210g',
                          target: '220g',
                          color: Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: _buildNutritionStat(
                          label: 'Fat',
                          value: '65g',
                          target: '70g',
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Water intake
                  Row(
                    children: [
                      const Icon(Icons.water_drop, color: Colors.blue),
                      const SizedBox(width: 8),
                      const Text(
                        'Water Intake',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '2.8L / 3.0L daily target',
                        style: TextStyle(
                          fontSize: 14,
                          color: lightGrey,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.93,
                      minHeight: 10,
                      backgroundColor: veryLightGrey,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
  
  // Helper widgets
  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: lightGrey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildHistoryListItem({
    required String date,
    required String value,
    required String change,
    required bool isPositive,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: TextStyle(
              fontSize: 14,
              color: lightGrey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: isPositive ? Colors.red : Colors.green,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                change,
                style: TextStyle(
                  color: isPositive ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildCircleProgress(
    String label,
    String value,
    String change,
    Color color,
    double progress,
  ) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 8,
                    backgroundColor: veryLightGrey,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      change,
                      style: TextStyle(
                        fontSize: 12,
                        color: change.startsWith('+') ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  
  Widget _buildMeasurementRow(String label, String current, String change) {
    final isPositive = change.startsWith('+');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            current,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            change,
            style: TextStyle(
              fontSize: 14,
              color: isPositive ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: lightGrey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCalendarDay(String day, int date, bool completed) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          day,
          style: TextStyle(
            fontSize: 12,
            color: lightGrey,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: completed ? Colors.green.withOpacity(0.2) : Colors.transparent,
            border: Border.all(
              color: completed ? Colors.green : veryLightGrey,
            ),
          ),
          child: Center(
            child: Text(
              date.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: completed ? Colors.green : lightGrey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Icon(
          completed ? Icons.check_circle : Icons.circle_outlined,
          size: 14,
          color: completed ? Colors.green : lightGrey,
        ),
      ],
    );
  }
  
  Widget _buildStrengthProgressRow(String exercise, String current, String progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            exercise,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            current,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            progress,
            style: TextStyle(
              fontSize: 14,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNutritionStat({
    required String label,
    required String value,
    required String target,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '/ $target',
                style: TextStyle(
                  fontSize: 14,
                  color: lightGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}