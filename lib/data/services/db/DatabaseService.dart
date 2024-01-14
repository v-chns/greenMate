import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService{
  static Database? _database;
  static final DatabaseService instance = DatabaseService._();

  DatabaseService._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // If _database is null, initialize it
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    // Get the documents directory
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'greenmate_localdb.db');

    // Open the database
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create your tables and perform any initial setup here
    await db.execute('CREATE TABLE my_plants (userPlantId INTEGER PRIMARY KEY, userImage TEXT, class TEXT)');
    await db.execute('CREATE TABLE my_tutorials (userTutorialId INTEGER PRIMARY KEY, class TEXT)');
    // Add more table creation statements if needed
  }
}