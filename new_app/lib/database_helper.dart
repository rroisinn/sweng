import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:new_app/example_candidate_model.dart'; // Import the candidate model

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }


  Future<Database> initDatabase() async {
  return await openDatabase(
    p.join(await getDatabasesPath(), 'app_database.db'),
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, password TEXT)',
      );
      await db.execute(
        'CREATE TABLE wishlist(id INTEGER PRIMARY KEY, userId INTEGER, name TEXT, image TEXT, link TEXT, price TEXT, brand TEXT, FOREIGN KEY(userId) REFERENCES users(id))',
      ); // Create the wishlist table with a userId column
      await db.execute(
        'CREATE TABLE preferences(username TEXT PRIMARY KEY, preference1 TEXT, preference2 TEXT, preference3 TEXT, preference4 TEXT)',
      );
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        // Perform migration from version 1 to version 2
        await db.execute(
          'ALTER TABLE wishlist ADD COLUMN userId INTEGER',
        );
      }
      if (oldVersion < 4) {
        // Perform migration from version 1 to version 2
        await db.execute(
        'CREATE TABLE preferences(username TEXT PRIMARY KEY, preference1 TEXT, preference2 TEXT, preference3 TEXT, preference4 TEXT)',
      );
      }
    },
    version: 4, // Update the version number
  );
}

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert(
      'users',
      user.toMapWithoutId(), // Use the toMapWithoutId method to exclude the id
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<void> insertPref(Preference pref) async {
    final db = await database;
    await db.insert(
      'preferences',
      pref.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> getUser(String username) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Method to insert a wishlist item associated with a user
  Future<void> insertWishlistItem(int? userId, ExampleCandidateModel candidate) async {
    final db = await database;
    await db.insert(
      'wishlist',
      {
        'userId': userId,
        'name': candidate.name,
        'image': candidate.image,
        'link': candidate.link,
        'price': candidate.price,
        'brand': candidate.brand,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<Preference?> getPref(String username) async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
    'preferences',
    where: 'username = ?',
    whereArgs: [username],
  );

  if (maps.isNotEmpty) {
    return Preference.fromMap(maps.first);
  } else {
    return null;
  }
}

  // Method to retrieve wishlist items for a specific user
  Future<List<ExampleCandidateModel>> getWishlistItems(int? userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'wishlist',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'id DESC',
    );
    return List.generate(maps.length, (i) {
      return ExampleCandidateModel(
        name: maps[i]['name'],
        image: maps[i]['image'],
        link: maps[i]['link'],
        price: maps[i]['price'],
        brand: maps[i]['brand'],
      );
    });
  }
}

class User {
  int? id;
  String username;
  String password;

  User({this.id,required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Include the id in the map
      'username': username,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'], // Retrieve the id from the map
      username: map['username'],
      password: map['password'],
    );
  }
  Map<String, dynamic> toMapWithoutId() {
  return {
    'username': username,
    'password': password,
  };
}
}
class Preference {
  //int id;
  String username; // Foreign key referencing the User table
  String preference1;
  String preference2;
  String preference3;
  String preference4;

  Preference({required this.username, required this.preference1, required this.preference2, required this.preference3, required this.preference4});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'preference1': preference1,
      'preference2': preference2,
      'preference3': preference3,
      'preference4': preference4,
    };
  }

  factory Preference.fromMap(Map<String, dynamic> map) {
    return Preference(
      //id: map['id'],
      username: map['username'],
      preference1: map['preference1'],
      preference2: map['preference2'],
      preference3: map['preference3'],
      preference4: map['preference4'],
    );
  }
  
}









