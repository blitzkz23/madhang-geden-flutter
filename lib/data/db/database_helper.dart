import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblFavorite = 'favorites';

  /// [_initalizeDatabase] is used to initialize the database by creating path and query to create table.
  Future<Database> _initalizeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase('$path/fav_restaurants.db', version: 1,
        onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE $_tblFavorite (
          id INTEGER PRIMARY KEY,
          name TEXT,
          description TEXT,
          pictureId TEXT,
          city TEXT,
          rating REAL,
          
        )''');
    });
    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initalizeDb();
    return _database;
  }

  /// [insertFavorites] is used to insert the restaurant favorites into the database.
  Future<void> insertFavorites(Restaurant restaurant) async {
    final db = await database;
    await db?.insert(_tblFavorite, restaurant.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// [getFavorites] is used to get the restaurant favorites from the database.
  Future<List<Restaurant>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblFavorite);

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  /// [getFavoritesById] is used to get the restaurant favorites from the database by id.
  Future<Map> getFavoritesById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblFavorite, where: 'id = ?', whereArgs: [id]);

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  /// [deleteFavorites] is used to delete the restaurant favorites from the database.
  Future<void> deleteFavorites(String id) async {
    final db = await database;
    await db?.delete(_tblFavorite, where: 'id = ?', whereArgs: [id]);
  }
}
