import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();
  static Database? _database;

  LocalDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tiziapp.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 5,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const realType = 'REAL NOT NULL';
    const intType = 'INTEGER NOT NULL';

    // Original Items table
    await db.execute('''
CREATE TABLE Items (
  id $idType,
  Name $textType,
  Detail $textType,
  Price $textType,
  Image $textType,
  Category $textType
)
''');

    // User Profile table
    await db.execute('''
CREATE TABLE UserProfile (
  id INTEGER PRIMARY KEY,
  name $textType,
  profilePicturePath TEXT
)
''');

    // Daily Nutrition Logs
    await db.execute('''
CREATE TABLE NutritionLogs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date $textType,
  totalCalories $intType,
  proteins $realType,
  carbs $realType,
  fats $realType,
  vitamins $realType,
  minerals $realType,
  UNIQUE(date)
)
''');

    // Food Entries (for detailed tracking)
    await db.execute('''
CREATE TABLE FoodEntries (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date $textType,
  foodName $textType,
  calories $intType,
  proteins $realType,
  carbs $realType,
  fats $realType,
  vitamins $realType,
  minerals $realType,
  timestamp $textType
)
''');

    // Workout Logs
    await db.execute('''
CREATE TABLE WorkoutLogs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date $textType,
  workoutType $textType,
  caloriesBurned $intType,
  timestamp $textType
)
''');

    // Supplement Intake
    await db.execute('''
CREATE TABLE SupplementIntake (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date $textType,
  supplementName $textType,
  taken $intType,
  timestamp $textType
)
''');

    // Supplement List (user's custom supplements)
    await db.execute('''
CREATE TABLE Supplements (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE
)
''');

    // Reset Configuration
    await db.execute('''
CREATE TABLE ResetConfig (
  id INTEGER PRIMARY KEY,
  lastResetDate $textType,
  resetIntervalHours INTEGER NOT NULL DEFAULT 24
)
''');

    // Insert default reset config
    await db.insert('ResetConfig', {
      'id': 1,
      'lastResetDate': DateTime.now().toIso8601String(),
      'resetIntervalHours': 24,
    });

    // Insert default supplements
    await db.insert('Supplements', {'name': 'Creatine Monohydrate'});
    await db.insert('Supplements', {'name': 'Protein Powder'});
    await db.insert('Supplements', {'name': 'Pre-Workout Supplement'});

    // Monthly Weight Tracking
    await db.execute('''
CREATE TABLE MonthlyWeightTracking (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  month $textType,
  weightChange REAL NOT NULL,
  totalCaloriesConsumed INTEGER NOT NULL,
  totalCaloriesBurned INTEGER NOT NULL,
  calorieBalance INTEGER NOT NULL,
  UNIQUE(month)
)
''');

    // Progress Posts (Social Media)
    await db.execute('''
CREATE TABLE ProgressPosts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  userName TEXT NOT NULL,
  userProfilePic TEXT,
  mediaPath TEXT NOT NULL,
  mediaType TEXT NOT NULL,
  caption TEXT,
  privacy TEXT NOT NULL,
  likes INTEGER NOT NULL DEFAULT 0,
  createdAt TEXT NOT NULL,
  thumbnailPath TEXT
)
''');

    // Post Likes
    await db.execute('''
CREATE TABLE PostLikes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  postId INTEGER NOT NULL,
  likedAt TEXT NOT NULL,
  FOREIGN KEY (postId) REFERENCES ProgressPosts(id) ON DELETE CASCADE
)
''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add new tables for version 2
      const textType = 'TEXT NOT NULL';
      const realType = 'REAL NOT NULL';
      const intType = 'INTEGER NOT NULL';

      await db.execute('''
CREATE TABLE UserProfile (
  id INTEGER PRIMARY KEY,
  name $textType,
  profilePicturePath TEXT
)
''');

      await db.execute('''
CREATE TABLE NutritionLogs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date $textType,
  totalCalories $intType,
  proteins $realType,
  carbs $realType,
  fats $realType,
  vitamins $realType,
  minerals $realType,
  UNIQUE(date)
)
''');

      await db.execute('''
CREATE TABLE FoodEntries (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date $textType,
  foodName $textType,
  calories $intType,
  proteins $realType,
  carbs $realType,
  fats $realType,
  vitamins $realType,
  minerals $realType,
  timestamp $textType
)
''');

      await db.execute('''
CREATE TABLE WorkoutLogs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date $textType,
  workoutType $textType,
  caloriesBurned $intType,
  timestamp $textType
)
''');

      await db.execute('''
CREATE TABLE SupplementIntake (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date $textType,
  supplementName $textType,
  taken $intType,
  timestamp $textType
)
''');

      await db.execute('''
CREATE TABLE Supplements (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE
)
''');

      await db.execute('''
CREATE TABLE ResetConfig (
  id INTEGER PRIMARY KEY,
  lastResetDate $textType,
  resetIntervalHours INTEGER NOT NULL DEFAULT 24
)
''');

      // Insert default data
      await db.insert('ResetConfig', {
        'id': 1,
        'lastResetDate': DateTime.now().toIso8601String(),
        'resetIntervalHours': 24,
      });

      await db.insert('Supplements', {'name': 'Creatine Monohydrate'});
      await db.insert('Supplements', {'name': 'Protein Powder'});
      await db.insert('Supplements', {'name': 'Pre-Workout Supplement'});
    }

    if (oldVersion < 3) {
      // Migration for version 3: Subscriptions and WorkoutRoutines
      await db.execute('''
CREATE TABLE Subscriptions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  type TEXT,
  name TEXT,
  imagePath TEXT,
  startDate TEXT,
  price REAL,
  description TEXT
)
''');

      await db.execute('''
CREATE TABLE WorkoutRoutines (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date TEXT,
  workoutName TEXT,
  duration TEXT,
  isCompleted INTEGER
)
''');
    }

    if (oldVersion < 4) {
      // Migration for version 4: MonthlyWeightTracking
      const textType = 'TEXT NOT NULL';
      
      await db.execute('''
CREATE TABLE MonthlyWeightTracking (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  month $textType,
  weightChange REAL NOT NULL,
  totalCaloriesConsumed INTEGER NOT NULL,
  totalCaloriesBurned INTEGER NOT NULL,
  calorieBalance INTEGER NOT NULL,
  UNIQUE(month)
)
''');
    }

    if (oldVersion < 5) {
      // Migration for version 5: ProgressPosts and PostLikes
      await db.execute('''
CREATE TABLE ProgressPosts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  userName TEXT NOT NULL,
  userProfilePic TEXT,
  mediaPath TEXT NOT NULL,
  mediaType TEXT NOT NULL,
  caption TEXT,
  privacy TEXT NOT NULL,
  likes INTEGER NOT NULL DEFAULT 0,
  createdAt TEXT NOT NULL,
  thumbnailPath TEXT
)
''');

      await db.execute('''
CREATE TABLE PostLikes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  postId INTEGER NOT NULL,
  likedAt TEXT NOT NULL,
  FOREIGN KEY (postId) REFERENCES ProgressPosts(id) ON DELETE CASCADE
)
''');
    }
  }

  Future<void> insertItem(Map<String, dynamic> item) async {
    final db = await instance.database;
    await db.insert('Items', item, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getItems(String category) async {
    final db = await instance.database;
    return await db.query('Items', where: 'Category = ?', whereArgs: [category]);
  }

  Future<List<Map<String, dynamic>>> getAllItems() async {
    final db = await instance.database;
    return await db.query('Items');
  }
}
