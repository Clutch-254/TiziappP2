import 'package:intl/intl.dart';
import '../widgets/local_database.dart';

class NutritionService {
  final LocalDatabase _db = LocalDatabase.instance;

  // Get today's date string for database queries
  String get today => DateFormat('yyyy-MM-dd').format(DateTime.now());

  // Check and perform daily reset if needed
  Future<void> checkAndResetDaily() async {
    final db = await _db.database;
    
    // Get reset config
    final List<Map<String, dynamic>> config = await db.query('ResetConfig', limit: 1);
    if (config.isEmpty) return;

    final lastResetStr = config.first['lastResetDate'] as String;
    final intervalHours = config.first['resetIntervalHours'] as int;
    
    final lastReset = DateTime.parse(lastResetStr);
    final now = DateTime.now();
    final difference = now.difference(lastReset).inHours;

    if (difference >= intervalHours) {
      // It's time to reset
      // We don't delete history, we just update the last reset date
      // The UI will query data for "today" which will be empty if it's a new day
      // For supplements, we might need to explicitly reset the "taken" status if we were tracking it in a non-date-specific way,
      // but our schema tracks SupplementIntake by date, so a new date means fresh empty records.
      
      // However, if the user wants the checkboxes to "reset", and we are viewing "today's" status,
      // simply querying by the new date handles the "reset" visually.
      
      await db.update(
        'ResetConfig',
        {'lastResetDate': now.toIso8601String()},
        where: 'id = ?',
        whereArgs: [1],
      );
    }
  }

  // Get today's nutrition summary
  Future<Map<String, dynamic>> getTodayNutrition() async {
    final db = await _db.database;
    final List<Map<String, dynamic>> result = await db.query(
      'NutritionLogs',
      where: 'date = ?',
      whereArgs: [today],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return {
        'totalCalories': 0,
        'proteins': 0.0,
        'carbs': 0.0,
        'fats': 0.0,
        'vitamins': 0.0,
        'minerals': 0.0,
      };
    }
  }

  // Add a food entry
  Future<void> addFoodEntry({
    required String name,
    required int calories,
    required double proteins,
    required double carbs,
    required double fats,
    required double vitamins,
    required double minerals,
  }) async {
    final db = await _db.database;
    
    // 1. Add to FoodEntries for detailed history
    await db.insert('FoodEntries', {
      'date': today,
      'foodName': name,
      'calories': calories,
      'proteins': proteins,
      'carbs': carbs,
      'fats': fats,
      'vitamins': vitamins,
      'minerals': minerals,
      'timestamp': DateTime.now().toIso8601String(),
    });

    // 2. Update or Create Daily Nutrition Log
    final current = await getTodayNutrition();
    
    if (current['totalCalories'] == 0 && current['proteins'] == 0.0) {
      // Create new record
      await db.insert('NutritionLogs', {
        'date': today,
        'totalCalories': calories,
        'proteins': proteins,
        'carbs': carbs,
        'fats': fats,
        'vitamins': vitamins,
        'minerals': minerals,
      });
    } else {
      // Update existing record
      await db.update(
        'NutritionLogs',
        {
          'totalCalories': (current['totalCalories'] as int) + calories,
          'proteins': (current['proteins'] as double) + proteins,
          'carbs': (current['carbs'] as double) + carbs,
          'fats': (current['fats'] as double) + fats,
          'vitamins': (current['vitamins'] as double) + vitamins,
          'minerals': (current['minerals'] as double) + minerals,
        },
        where: 'date = ?',
        whereArgs: [today],
      );
    }

    // Update monthly weight tracking
    await updateMonthlyWeightTracking();
  }

  // Get today's calories burned
  Future<int> getTodayCaloriesBurned() async {
    final db = await _db.database;
    final result = await db.rawQuery(
      'SELECT SUM(caloriesBurned) as total FROM WorkoutLogs WHERE date = ?',
      [today],
    );
    
    if (result.isNotEmpty && result.first['total'] != null) {
      return result.first['total'] as int;
    }
    return 0;
  }

  Future<void> logWorkout({
    required String type,
    required int calories,
  }) async {
    final db = await _db.database;
    await db.insert('WorkoutLogs', {
      'date': today,
      'workoutType': type,
      'caloriesBurned': calories,
      'timestamp': DateTime.now().toIso8601String(),
    });

    // Update monthly weight tracking
    await updateMonthlyWeightTracking();
  }

  // Get all available supplements
  Future<List<String>> getSupplementsList() async {
    final db = await _db.database;
    final result = await db.query('Supplements');
    return result.map((e) => e['name'] as String).toList();
  }

  // Add a new custom supplement
  Future<void> addCustomSupplement(String name) async {
    final db = await _db.database;
    await db.insert('Supplements', {'name': name});
  }

  // Get today's supplement intake status
  Future<Map<String, bool>> getTodaySupplementStatus() async {
    final db = await _db.database;
    final allSupplements = await getSupplementsList();
    final intakeRecords = await db.query(
      'SupplementIntake',
      where: 'date = ?',
      whereArgs: [today],
    );

    Map<String, bool> status = {};
    
    // Initialize all as false
    for (var supp in allSupplements) {
      status[supp] = false;
    }

    // Update with records
    for (var record in intakeRecords) {
      final name = record['supplementName'] as String;
      final taken = (record['taken'] as int) == 1;
      status[name] = taken;
    }

    return status;
  }

  // Toggle supplement intake
  Future<void> toggleSupplement(String name, bool taken) async {
    final db = await _db.database;
    
    // Check if record exists for today
    final existing = await db.query(
      'SupplementIntake',
      where: 'date = ? AND supplementName = ?',
      whereArgs: [today, name],
    );

    if (existing.isNotEmpty) {
      await db.update(
        'SupplementIntake',
        {'taken': taken ? 1 : 0, 'timestamp': DateTime.now().toIso8601String()},
        where: 'id = ?',
        whereArgs: [existing.first['id']],
      );
    } else {
      await db.insert('SupplementIntake', {
        'date': today,
        'supplementName': name,
        'taken': taken ? 1 : 0,
        'timestamp': DateTime.now().toIso8601String(),
      });
    }
  }
  // ... (existing methods)

  // --- Supplement Management ---

  Future<void> removeSupplement(String name) async {
    final db = await LocalDatabase.instance.database;
    // Remove from Supplements list
    await db.delete(
      'Supplements',
      where: 'name = ?',
      whereArgs: [name],
    );
    // Also remove any intake records for today to keep it clean (optional)
    await db.delete(
      'SupplementIntake',
      where: 'supplementName = ? AND date = ?',
      whereArgs: [name, today],
    );
  }

  // --- Subscription Management ---

  Future<void> addSubscription({
    required String type,
    required String name,
    required String imagePath,
    required double price,
    required String description,
  }) async {
    final db = await LocalDatabase.instance.database;
    await db.insert('Subscriptions', {
      'type': type,
      'name': name,
      'imagePath': imagePath,
      'startDate': DateTime.now().toIso8601String(),
      'price': price,
      'description': description,
    });
  }

  Future<void> removeSubscription(int id) async {
    final db = await LocalDatabase.instance.database;
    await db.delete(
      'Subscriptions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getSubscriptions(String type) async {
    final db = await LocalDatabase.instance.database;
    return await db.query(
      'Subscriptions',
      where: 'type = ?',
      whereArgs: [type],
    );
  }
  
  Future<bool> isSubscribed(String name) async {
    final db = await LocalDatabase.instance.database;
    final result = await db.query(
      'Subscriptions',
      where: 'name = ?',
      whereArgs: [name],
    );
    return result.isNotEmpty;
  }

  // --- Workout Routine Management ---

  Future<void> addWorkoutRoutine({
    required DateTime date,
    required String workoutName,
    required String duration,
  }) async {
    final db = await LocalDatabase.instance.database;
    await db.insert('WorkoutRoutines', {
      'date': date.toIso8601String().split('T')[0],
      'workoutName': workoutName,
      'duration': duration,
      'isCompleted': 0,
    });
  }

  Future<void> removeWorkoutRoutine(int id) async {
    final db = await LocalDatabase.instance.database;
    await db.delete(
      'WorkoutRoutines',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> toggleWorkoutCompletion(int id, bool isCompleted) async {
    final db = await LocalDatabase.instance.database;
    await db.update(
      'WorkoutRoutines',
      {'isCompleted': isCompleted ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getWorkoutRoutines(DateTime date) async {
    final db = await LocalDatabase.instance.database;
    final dateString = date.toIso8601String().split('T')[0];
    return await db.query(
      'WorkoutRoutines',
      where: 'date = ?',
      whereArgs: [dateString],
    );
  }

  // --- Monthly Weight Tracking ---

  /// Calculate weight change from calorie balance
  /// Formula: 1 kg ≈ 7700 calories
  double calculateWeightChange(int calorieBalance) {
    return calorieBalance / 7700.0;
  }

  /// Update monthly weight tracking for the current month
  Future<void> updateMonthlyWeightTracking() async {
    final db = await LocalDatabase.instance.database;
    final now = DateTime.now();
    final currentMonth = DateFormat('yyyy-MM').format(now);
    
    // Get the start and end dates for the current month
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);
    
    final startDateStr = DateFormat('yyyy-MM-dd').format(startOfMonth);
    final endDateStr = DateFormat('yyyy-MM-dd').format(endOfMonth);

    // Calculate total calories consumed for the month
    final consumedResult = await db.rawQuery(
      'SELECT SUM(totalCalories) as total FROM NutritionLogs WHERE date >= ? AND date <= ?',
      [startDateStr, endDateStr],
    );
    final totalConsumed = (consumedResult.first['total'] as int?) ?? 0;

    // Calculate total calories burned for the month
    final burnedResult = await db.rawQuery(
      'SELECT SUM(caloriesBurned) as total FROM WorkoutLogs WHERE date >= ? AND date <= ?',
      [startDateStr, endDateStr],
    );
    final totalBurned = (burnedResult.first['total'] as int?) ?? 0;

    // Calculate calorie balance and weight change
    final calorieBalance = totalConsumed - totalBurned;
    final weightChange = calculateWeightChange(calorieBalance);

    // Insert or update the monthly record
    final existing = await db.query(
      'MonthlyWeightTracking',
      where: 'month = ?',
      whereArgs: [currentMonth],
    );

    if (existing.isNotEmpty) {
      await db.update(
        'MonthlyWeightTracking',
        {
          'weightChange': weightChange,
          'totalCaloriesConsumed': totalConsumed,
          'totalCaloriesBurned': totalBurned,
          'calorieBalance': calorieBalance,
        },
        where: 'month = ?',
        whereArgs: [currentMonth],
      );
    } else {
      await db.insert('MonthlyWeightTracking', {
        'month': currentMonth,
        'weightChange': weightChange,
        'totalCaloriesConsumed': totalConsumed,
        'totalCaloriesBurned': totalBurned,
        'calorieBalance': calorieBalance,
      });
    }
  }

  /// Get monthly weight gain data for the last 12 months (positive values only)
  Future<List<double>> getMonthlyWeightGainData() async {
    final db = await LocalDatabase.instance.database;
    final now = DateTime.now();
    List<double> weightGainData = [];

    for (int i = 11; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i, 1);
      final monthStr = DateFormat('yyyy-MM').format(month);
      
      final result = await db.query(
        'MonthlyWeightTracking',
        where: 'month = ?',
        whereArgs: [monthStr],
      );

      if (result.isNotEmpty) {
        final weightChange = result.first['weightChange'] as double;
        // Only include positive values (weight gain)
        weightGainData.add(weightChange > 0 ? weightChange : 0.0);
      } else {
        weightGainData.add(0.0);
      }
    }

    return weightGainData;
  }

  /// Get monthly weight loss data for the last 12 months (absolute values of negative changes)
  Future<List<double>> getMonthlyWeightLossData() async {
    final db = await LocalDatabase.instance.database;
    final now = DateTime.now();
    List<double> weightLossData = [];

    for (int i = 11; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i, 1);
      final monthStr = DateFormat('yyyy-MM').format(month);
      
      final result = await db.query(
        'MonthlyWeightTracking',
        where: 'month = ?',
        whereArgs: [monthStr],
      );

      if (result.isNotEmpty) {
        final weightChange = result.first['weightChange'] as double;
        // Only include negative values (weight loss), convert to positive
        weightLossData.add(weightChange < 0 ? weightChange.abs() : 0.0);
      } else {
        weightLossData.add(0.0);
      }
    }

    return weightLossData;
  }

  /// Get month labels for the last 12 months
  List<String> getMonthLabels() {
    final now = DateTime.now();
    List<String> labels = [];

    for (int i = 11; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i, 1);
      labels.add(DateFormat('MMM').format(month));
    }

    return labels;
  }

  /// Get monthly calorie balance summary
  Future<Map<String, dynamic>> getMonthlyCalorieBalance(String monthStr) async {
    final db = await LocalDatabase.instance.database;
    
    final result = await db.query(
      'MonthlyWeightTracking',
      where: 'month = ?',
      whereArgs: [monthStr],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return {
        'month': monthStr,
        'weightChange': 0.0,
        'totalCaloriesConsumed': 0,
        'totalCaloriesBurned': 0,
        'calorieBalance': 0,
      };
    }
  }
}
