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

  // Log a workout
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
}
