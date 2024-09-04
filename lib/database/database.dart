import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_input.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE userInput(id INTEGER PRIMARY KEY, input TEXT)",
        );
      },
    );
  }

  Future<int> insertUserInput(String input) async {
    final db = await database;
    return await db.insert('userInput', {'input': input});
  }

  Future<List<Map<String, dynamic>>> getUserInput() async {
    final db = await database;
    return await db.query('userInput');
  }
}
