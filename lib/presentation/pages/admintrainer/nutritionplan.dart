import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Food {
  final String name;
  final String quantity;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;

  Food({
    required this.name,
    required this.quantity,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });
}

class Meal {
  final String name;
  final String time;
  final List<Food> foods;
  bool completed;

  Meal({
    required this.name,
    required this.time,
    required this.foods,
    this.completed = false,
  });
}

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

  // Current day
  DateTime _selectedDay = DateTime.now();

  // Sample meal plan for the day
  final List<Meal> _meals = [
    Meal(
      name: "Breakfast",
      time: "7:00 AM",
      foods: [
        Food(
            name: "Scrambled eggs",
            quantity: "2 large",
            calories: 180,
            protein: 14,
            carbs: 2,
            fat: 12),
        Food(
            name: "Whole grain toast",
            quantity: "1 slice",
            calories: 80,
            protein: 4,
            carbs: 15,
            fat: 1),
        Food(
            name: "Avocado",
            quantity: "1/4",
            calories: 80,
            protein: 1,
            carbs: 4,
            fat: 7),
        Food(
            name: "Fresh spinach",
            quantity: "1 cup",
            calories: 10,
            protein: 1,
            carbs: 1,
            fat: 0),
      ],
    ),
    Meal(
      name: "Morning Snack",
      time: "10:00 AM",
      foods: [
        Food(
            name: "Apple",
            quantity: "1 medium",
            calories: 95,
            protein: 0,
            carbs: 25,
            fat: 0),
        Food(
            name: "Almond butter",
            quantity: "1 tbsp",
            calories: 100,
            protein: 3,
            carbs: 3,
            fat: 9),
      ],
    ),
    Meal(
      name: "Lunch",
      time: "1:00 PM",
      foods: [
        Food(
            name: "Grilled chicken breast",
            quantity: "4 oz",
            calories: 180,
            protein: 35,
            carbs: 0,
            fat: 4),
        Food(
            name: "Mixed greens salad",
            quantity: "2 cups",
            calories: 15,
            protein: 1,
            carbs: 3,
            fat: 0),
        Food(
            name: "Quinoa",
            quantity: "1/2 cup",
            calories: 110,
            protein: 4,
            carbs: 20,
            fat: 1.5),
        Food(
            name: "Olive oil dressing",
            quantity: "1 tbsp",
            calories: 120,
            protein: 0,
            carbs: 0,
            fat: 14),
      ],
    ),
    Meal(
      name: "Afternoon Snack",
      time: "4:00 PM",
      foods: [
        Food(
            name: "Greek yogurt",
            quantity: "150g",
            calories: 130,
            protein: 15,
            carbs: 6,
            fat: 4),
        Food(
            name: "Mixed berries",
            quantity: "1/4 cup",
            calories: 25,
            protein: 0.5,
            carbs: 5,
            fat: 0),
        Food(
            name: "Honey",
            quantity: "1 tsp",
            calories: 20,
            protein: 0,
            carbs: 6,
            fat: 0),
      ],
    ),
    Meal(
      name: "Dinner",
      time: "7:00 PM",
      foods: [
        Food(
            name: "Salmon fillet",
            quantity: "5 oz",
            calories: 280,
            protein: 31,
            carbs: 0,
            fat: 17),
        Food(
            name: "Steamed broccoli",
            quantity: "1 cup",
            calories: 30,
            protein: 2.5,
            carbs: 6,
            fat: 0),
        Food(
            name: "Brown rice",
            quantity: "1/2 cup",
            calories: 110,
            protein: 2.5,
            carbs: 23,
            fat: 1),
        Food(
            name: "Lemon wedge",
            quantity: "1/4 lemon",
            calories: 5,
            protein: 0,
            carbs: 1.5,
            fat: 0),
      ],
    ),
  ];

  // Get total daily nutrition
  Map<String, double> get _dailyTotals {
    double calories = 0;
    double protein = 0;
    double carbs = 0;
    double fat = 0;

    for (final meal in _meals) {
      for (final food in meal.foods) {
        calories += food.calories;
        protein += food.protein;
        carbs += food.carbs;
        fat += food.fat;
      }
    }

    return {
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
    };
  }

  // Toggle meal completion status
  void _toggleMealCompletion(int index) {
    setState(() {
      _meals[index].completed = !_meals[index].completed;
    });
  }

  // Change selected day
  void _changeDay(int days) {
    setState(() {
      _selectedDay = _selectedDay.add(Duration(days: days));
    });
  }

  // Show info dialog
  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nutrition Plan Info'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
                'This plan is designed to help you track your daily nutrition intake.'),
            SizedBox(height: 8),
            Text('• Mark meals as completed by tapping the circle.'),
            Text('• View nutrition details for each meal.'),
            Text('• Navigate between days using the arrows.'),
            SizedBox(height: 8),
            Text('Your daily targets:'),
            Text('Calories: 1,800-2,000 kcal'),
            Text('Protein: 100-120g'),
            Text('Carbs: 150-180g'),
            Text('Fat: 50-60g'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dailyTotals = _dailyTotals;
    final completedMeals = _meals.where((meal) => meal.completed).length;
    final progress = completedMeals / _meals.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Nutrition Plan'),
        backgroundColor: primaryGrey,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
          ),
        ],
      ),
      body: Container(
        color: backgroundGrey,
        child: Column(
          children: [
            // Day selector
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => _changeDay(-1),
                    color: primaryGrey,
                  ),
                  Column(
                    children: [
                      Text(
                        DateFormat('EEEE').format(_selectedDay),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryGrey,
                        ),
                      ),
                      Text(
                        DateFormat('MMMM d, y').format(_selectedDay),
                        style: TextStyle(
                          fontSize: 14,
                          color: lightGrey,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () => _changeDay(1),
                    color: primaryGrey,
                  ),
                ],
              ),
            ),

            // Progress and nutrition summary
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                children: [
                  // Progress bar
                  Row(
                    children: [
                      Text(
                        "Today's Progress: $completedMeals/${_meals.length} meals",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${(progress * 100).toInt()}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: progress > 0.5 ? Colors.green : primaryGrey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: veryLightGrey,
                      color: primaryGrey,
                      minHeight: 10,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Nutrition summary
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNutrientIndicator(
                          "Calories",
                          dailyTotals['calories']!.toInt().toString(),
                          Colors.amber),
                      _buildNutrientIndicator(
                          "Protein",
                          "${dailyTotals['protein']!.toInt()}g",
                          Colors.red.shade300),
                      _buildNutrientIndicator(
                          "Carbs",
                          "${dailyTotals['carbs']!.toInt()}g",
                          Colors.blue.shade300),
                      _buildNutrientIndicator(
                          "Fat",
                          "${dailyTotals['fat']!.toInt()}g",
                          Colors.green.shade300),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Meals list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: _meals.length,
                itemBuilder: (context, index) {
                  return _buildMealCard(index);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Water tracking feature'),
              duration: Duration(seconds: 1),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.water_drop),
      ),
    );
  }

  Widget _buildNutrientIndicator(String label, String value, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            label == "Calories"
                ? Icons.local_fire_department
                : label == "Protein"
                    ? Icons.fitness_center
                    : label == "Carbs"
                        ? Icons.grain
                        : Icons.opacity,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: lightGrey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildMealCard(int index) {
    final meal = _meals[index];

    // Calculate meal total nutrition
    double totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;

    for (final food in meal.foods) {
      totalCalories += food.calories;
      totalProtein += food.protein;
      totalCarbs += food.carbs;
      totalFat += food.fat;
    }

    return Card(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Meal header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: meal.completed ? Colors.green.shade50 : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  meal.name == "Breakfast"
                      ? Icons.breakfast_dining
                      : meal.name == "Lunch"
                          ? Icons.lunch_dining
                          : meal.name == "Dinner"
                              ? Icons.dinner_dining
                              : Icons.fastfood,
                  color: primaryGrey,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        meal.time,
                        style: TextStyle(
                          fontSize: 14,
                          color: lightGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${totalCalories.toInt()} cal",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "P: ${totalProtein.toInt()}g | C: ${totalCarbs.toInt()}g | F: ${totalFat.toInt()}g",
                      style: TextStyle(
                        fontSize: 12,
                        color: lightGrey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: () => _toggleMealCompletion(index),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: meal.completed ? Colors.green : lightGrey,
                        width: 2,
                      ),
                      color: meal.completed ? Colors.green : Colors.transparent,
                    ),
                    child: Icon(
                      Icons.check,
                      size: 16,
                      color: meal.completed ? Colors.white : Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Food items
          ...meal.foods
              .map((food) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                food.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                food.quantity,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: lightGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${food.calories.toInt()} cal",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          "P:${food.protein.toInt()}g",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red.shade300,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "C:${food.carbs.toInt()}g",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade300,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "F:${food.fat.toInt()}g",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green.shade300,
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }
}
