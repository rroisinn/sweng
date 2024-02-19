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
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        // Perform migration from version 1 to version 2
        await db.execute(
          'ALTER TABLE wishlist ADD COLUMN userId INTEGER',
        );
      }
    },
    version: 2, // Update the version number
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

  // Method to retrieve wishlist items for a specific user
  Future<List<ExampleCandidateModel>> getWishlistItems(int? userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'wishlist',
      where: 'userId = ?',
      whereArgs: [userId],
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



