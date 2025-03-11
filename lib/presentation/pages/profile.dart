import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' show pi;

class Profile extends StatefulWidget {
  final Function(DateTime)? onDateSelected;
  final Color backgroundColor;

  const Profile({
    Key? key,
    this.onDateSelected,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late DateTime _selectedDate;
  late List<DateTime> _weekDays;
  late PageController _pageController;
  int _selectedIconIndex = 0; // Set the food icon as the default selected icon

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _pageController = PageController(initialPage: 0);
    _generateWeekDays(DateTime.now());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _generateWeekDays(DateTime date) {
    // Find the start of the week (Monday)
    DateTime startOfWeek = date.subtract(Duration(days: date.weekday - 1));

    _weekDays = List.generate(7, (index) {
      return startOfWeek.add(Duration(days: index));
    });
  }

  void _navigateToWeek(int direction) {
    setState(() {
      DateTime newDate = _selectedDate.add(Duration(days: 7 * direction));
      _selectedDate = newDate;
      _generateWeekDays(newDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3),
                    child: Material(
                      elevation: 10.0,
                      borderRadius: BorderRadius.circular(60),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.asset(
                          "Images/Juma.png",
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3 - 40),
                    child: Text(
                      "Max Achebi",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3 + 100),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildIconButton(0, Icons.fastfood), // Food icon
                            SizedBox(width: 40),
                            _buildIconButton(
                                1, Icons.access_time), // Clock icon
                            SizedBox(width: 40),
                            _buildIconButton(
                                2, Icons.contacts), // Phonebook icon
                            SizedBox(width: 40),
                            _buildIconButton(
                                3, Icons.bar_chart), // Bar graph icon
                          ],
                        ),
                        // Add the nutrition donut chart if the food icon is selected
                        if (_selectedIconIndex == 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Column(
                              children: [
                                NutritionInfoSection(),
                                SizedBox(height: 30),
                                CaloriesBalanceSection(),
                                SizedBox(height: 30),
                                SupplementIntakeSection(),
                                SizedBox(height: 50),
                              ],
                            ),
                          ),
                        // Show today's routine if the clock icon is selected
                        if (_selectedIconIndex == 1)
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Column(
                              children: [
                                Text(
                                  "Today's Routine",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                WorkoutRoutine(selectedDate: _selectedDate),
                              ],
                            ),
                          ),
                        // Show trainer, nutritionist, and gym sections if the phonebook icon is selected
                        if (_selectedIconIndex == 2)
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Column(
                              children: [
                                TrainerSection(),
                                SizedBox(height: 20),
                                NutritionistSection(),
                                SizedBox(height: 20),
                                GymSection(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8, bottom: 16),
                  color: widget.backgroundColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon:
                                  Icon(Icons.chevron_left, color: Colors.grey),
                              onPressed: () => _navigateToWeek(-1),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                            Text(
                              DateFormat('MMMM yyyy').format(_weekDays[0]),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            IconButton(
                              icon:
                                  Icon(Icons.chevron_right, color: Colors.grey),
                              onPressed: () => _navigateToWeek(1),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: _weekDays.map((day) {
                          bool isToday = _isToday(day);
                          bool isSelected = _isSameDay(day, _selectedDate);

                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedDate = day;
                                  if (widget.onDateSelected != null) {
                                    widget.onDateSelected!(day);
                                  }
                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    DateFormat('E').format(day).substring(0, 3),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: isSelected
                                          ? Colors.grey
                                          : Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? Colors.grey
                                          : isToday
                                              ? Colors.grey.withOpacity(0.1)
                                              : Colors.transparent,
                                    ),
                                    child: Center(
                                      child: Text(
                                        day.day.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: isToday || isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: isSelected
                                              ? Colors.white
                                              : isToday
                                                  ? Colors.grey
                                                  : Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build an icon button
  Widget _buildIconButton(int index, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIconIndex = index; // Update the selected icon index
        });
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              _selectedIconIndex == index ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
          border: _selectedIconIndex == index
              ? Border.all(color: Colors.grey, width: 2)
              : null,
        ),
        child: Icon(
          icon,
          size: 30,
          color: _selectedIconIndex == index ? Colors.grey : Colors.grey[600],
        ),
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool _isMonday(DateTime date) {
    return date.weekday == DateTime.monday;
  }

  bool _isThursday(DateTime date) {
    return date.weekday == DateTime.thursday;
  }
}

// New Workout Routine Widget
class WorkoutRoutine extends StatefulWidget {
  final DateTime selectedDate;

  WorkoutRoutine({required this.selectedDate});

  @override
  _WorkoutRoutineState createState() => _WorkoutRoutineState();
}

class _WorkoutRoutineState extends State<WorkoutRoutine> {
  // Map to track workout status
  Map<String, bool> workoutStatus = {};

  @override
  void initState() {
    super.initState();
    _initializeWorkoutStatus();
  }

  void _initializeWorkoutStatus() {
    if (_isMonday(widget.selectedDate) || _isThursday(widget.selectedDate)) {
      workoutStatus = {
        "Preacher Curl 3 x 14": false,
        "Bench Press 3 x 14": false,
        "Hammer Curl 3 x 14": false,
        "Peck Deck": false,
        "Lateral Raises": false,
        "Inclined Dumbbell Press": false,
        "Cardio 45 mins": false,
      };
    } else if (_isTuesday(widget.selectedDate) ||
        _isFriday(widget.selectedDate)) {
      workoutStatus = {
        "Barbell Squats 3 x 14": false,
        "Quad Extension 3 x 14": false,
        "Romanian Deadlifts 3 x 14": false,
        "Hamstring Curls 3 x 14": false,
        "Upper Back Dumbbell Row 3 x 14": false,
        "Lat Dumbbell Row 3 x 14": false,
        "Elbow Extension 3 x 14": false,
        "Skull Crushers 3 x 14": false,
        "Cardio 45 mins": false,
      };
    } else {
      workoutStatus = {
        "Rest Day": false,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (workoutStatus.keys.first == "Rest Day")
          Text(
            "Rest Day",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          )
        else
          ...workoutStatus.keys
              .map((workout) => _buildWorkoutCheckbox(workout))
              .toList(),
      ],
    );
  }

  Widget _buildWorkoutCheckbox(String workout) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Checkbox(
            value: workoutStatus[workout],
            onChanged: (bool? value) {
              setState(() {
                workoutStatus[workout] = value ?? false;
              });
            },
            activeColor: Colors.grey[800],
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              workout,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
                decoration: workoutStatus[workout]!
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isMonday(DateTime date) {
    return date.weekday == DateTime.monday;
  }

  bool _isThursday(DateTime date) {
    return date.weekday == DateTime.thursday;
  }

  bool _isTuesday(DateTime date) {
    return date.weekday == DateTime.tuesday;
  }

  bool _isFriday(DateTime date) {
    return date.weekday == DateTime.friday;
  }
}

// Trainer Section
class TrainerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Action when the trainer button is pressed
        print("Trainer button pressed");
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("Images/PnM.png"), // Placeholder image
            radius: 30,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Trainer: PnM",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Subscription ends in 10 days",
                  style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

// Nutritionist Section
class NutritionistSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Action when the nutritionist button is pressed
        print("Nutritionist button pressed");
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage:
                AssetImage("Images/kisha.png"), // Placeholder image
            radius: 30,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nutritionist: Kisha",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Subscription ends in 3 days",
                  style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

// Gym Section
class GymSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Action when the gym button is pressed
        print("Gym button pressed");
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage:
                AssetImage("Images/gordon.png"), // Placeholder image
            radius: 30,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Gym: Gordon's Gym",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Subscription ends in 20 days",
                  style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

// Nutrition Info Section
class NutritionInfoSection extends StatelessWidget {
  final int totalCalories = 1850;
  final double proteins = 85.2;
  final double carbs = 210.5;
  final double vitamins = 750.8; // in mg
  final double minerals = 15.4; // in g

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side with donut chart
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Calories Consumed",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 8),
              Text(
                "$totalCalories kcal",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: 100,
                height: 100,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      painter: DonutChartPainter(),
                      size: Size(100, 100),
                    ),
                    Text(
                      "Daily",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem('Protein', Colors.grey[800]!),
                    _buildLegendItem('Carbs', Colors.grey[400]!),
                    _buildLegendItem('Vitamins', Colors.grey),
                    _buildLegendItem('Minerals', Colors.black),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(width: 40),

          // Right side with nutrition details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nutrition Details",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 16),
              _buildNutrientInfo("Proteins", "${proteins.toStringAsFixed(1)} g",
                  Colors.grey[800]!),
              SizedBox(height: 12),
              _buildNutrientInfo("Carbohydrates",
                  "${carbs.toStringAsFixed(1)} g", Colors.grey[400]!),
              SizedBox(height: 12),
              _buildNutrientInfo(
                  "Vitamins", "${vitamins.toStringAsFixed(1)} mg", Colors.grey),
              SizedBox(height: 12),
              _buildNutrientInfo(
                  "Minerals", "${minerals.toStringAsFixed(1)} g", Colors.black),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildNutrientInfo(String label, String value, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Calories Balance Section
class CaloriesBalanceSection extends StatelessWidget {
  final int caloriesConsumed = 1850;
  final int caloriesBurned = 1350;
  final int netCalories = 500; // consumed - burned

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side with donut chart
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Calories Balance",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Net: $netCalories kcal",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: 100,
                height: 100,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      painter: CaloriesBalanceChartPainter(
                        consumed: caloriesConsumed,
                        burned: caloriesBurned,
                      ),
                      size: Size(100, 100),
                    ),
                    Text(
                      "Daily",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem('Consumed', Colors.grey[800]!),
                    _buildLegendItem('Burned', Colors.black),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(width: 40),

          // Right side with calorie balance details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Energy Balance",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 16),
              _buildCalorieInfo(
                  "Consumed", "$caloriesConsumed kcal", Colors.grey[800]!),
              SizedBox(height: 12),
              _buildCalorieInfo("Burned", "$caloriesBurned kcal", Colors.black),
              SizedBox(height: 12),
              Divider(color: Colors.grey[400]),
              SizedBox(height: 12),
              _buildCalorieInfo("Net Balance", "$netCalories kcal",
                  netCalories > 0 ? Colors.green[700]! : Colors.red[700]!,
                  isHighlighted: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildCalorieInfo(String label, String value, Color color,
      {bool isHighlighted = false}) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: isHighlighted ? 18 : 16,
                fontWeight: FontWeight.bold,
                color: isHighlighted ? color : Colors.grey[900],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Supplement Intake Section with daily checkboxes
class SupplementIntakeSection extends StatefulWidget {
  @override
  _SupplementIntakeSectionState createState() =>
      _SupplementIntakeSectionState();
}

class _SupplementIntakeSectionState extends State<SupplementIntakeSection> {
  // Map to track supplement intake status
  Map<String, bool> supplementStatus = {
    "Creatine Monohydrate": false,
    "Protein Powder": false,
    "Pre-Workout Supplement": false,
    "Other Supplements": false,
  };

  @override
  void initState() {
    super.initState();
    // Check if we need to reset checkboxes based on last reset date
    _checkAndResetDailyStatus();
  }

  // Method to check if we need to reset checkboxes (every 24 hours)
  void _checkAndResetDailyStatus() {
    DateTime now = DateTime.now();
    DateTime lastReset = now; // This would be retrieved from storage

    // If it's a new day, reset all checkboxes
    if (now.day != lastReset.day ||
        now.month != lastReset.month ||
        now.year != lastReset.year) {
      setState(() {
        supplementStatus.forEach((key, value) {
          supplementStatus[key] = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Supplement Intake",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Track your daily supplements. Checkboxes reset every 24 hours.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 16),
          ...supplementStatus.keys
              .map((supplement) => _buildSupplementCheckbox(supplement))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildSupplementCheckbox(String supplement) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: supplementStatus[supplement],
              onChanged: (bool? value) {
                setState(() {
                  supplementStatus[supplement] = value ?? false;
                });
              },
              activeColor: Colors.grey[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              supplement,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
                decoration: supplementStatus[supplement]!
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),
          Text(
            supplementStatus[supplement]! ? "Taken" : "Not taken",
            style: TextStyle(
              fontSize: 14,
              color: supplementStatus[supplement]!
                  ? Colors.green[700]
                  : Colors.red[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for Donut Chart (Nutrition)
class DonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final innerRadius = radius * 0.6; // Size of the donut hole

    // Define the colors as specified
    final proteinColor = Colors.grey[800]!; // Dark grey
    final carbsColor = Colors.grey[400]!; // Light grey
    final vitaminsColor = Colors.grey; // Medium grey
    final mineralsColor = Colors.black; // Black

    // Sample data percentages (adjust as needed)
    final proteinPercent = 0.35; // 35%
    final carbsPercent = 0.40; // 40%
    final vitaminsPercent = 0.15; // 15%
    final mineralsPercent = 0.10; // 10%

    // Paint configurations
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius - innerRadius;

    // Starting angle is -pi/2 (top of the circle)
    double startAngle = -pi / 2;

    // Draw protein section
    paint.color = proteinColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (paint.strokeWidth / 2)),
      startAngle,
      2 * pi * proteinPercent,
      false,
      paint,
    );
    startAngle += 2 * pi * proteinPercent;

    // Draw carbs section
    paint.color = carbsColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (paint.strokeWidth / 2)),
      startAngle,
      2 * pi * carbsPercent,
      false,
      paint,
    );
    startAngle += 2 * pi * carbsPercent;

    // Draw vitamins section
    paint.color = vitaminsColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (paint.strokeWidth / 2)),
      startAngle,
      2 * pi * vitaminsPercent,
      false,
      paint,
    );
    startAngle += 2 * pi * vitaminsPercent;

    // Draw minerals section
    paint.color = mineralsColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (paint.strokeWidth / 2)),
      startAngle,
      2 * pi * mineralsPercent,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// Custom Painter for Calories Balance Chart
class CaloriesBalanceChartPainter extends CustomPainter {
  final int consumed;
  final int burned;

  CaloriesBalanceChartPainter({
    required this.consumed,
    required this.burned,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final innerRadius = radius * 0.6; // Size of the donut hole

    // Define the colors
    final consumedColor = Colors.grey[800]!; // Dark grey for calories consumed
    final burnedColor = Colors.black; // Black for calories burned

    // Calculate percentages
    final total = consumed + burned.toDouble();
    final consumedPercent = consumed / total;
    final burnedPercent = burned / total;

    // Paint configurations
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius - innerRadius;

    // Starting angle is -pi/2 (top of the circle)
    double startAngle = -pi / 2;

    // Draw consumed section
    paint.color = consumedColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (paint.strokeWidth / 2)),
      startAngle,
      2 * pi * consumedPercent,
      false,
      paint,
    );
    startAngle += 2 * pi * consumedPercent;

    // Draw burned section
    paint.color = burnedColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (paint.strokeWidth / 2)),
      startAngle,
      2 * pi * burnedPercent,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
