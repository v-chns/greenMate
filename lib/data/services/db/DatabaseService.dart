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
    return await openDatabase(path, version: 3, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create your tables and perform any initial setup here
    await db.execute('CREATE TABLE my_plants (userPlantId INTEGER PRIMARY KEY, userImage TEXT, class TEXT)');
    await db.execute('CREATE TABLE my_tutorials (userTutorialId INTEGER PRIMARY KEY, class TEXT)');
    // Add more table creation statements if needed
  }

  Future<void> _onUpgrade(Database db, oldVersion, newVersion) async {
        // Handle database upgrades here
        //if (oldVersion < 1) {
          // Perform the necessary migration to add a new column
          // await db.execute('ALTER TABLE my_tutorials ADD COLUMN tutorial TEXT DEFAULT ""');
          await db.execute('DROP TABLE my_tutorials');
          await db.execute('CREATE TABLE my_tutorials (userTutorialId INTEGER PRIMARY KEY, class TEXT, tutorial TEXT)');
        //}
      }
}