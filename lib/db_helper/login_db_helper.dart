import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test_app/auth/data/models/user_model.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await openDatabase(
      join(await getDatabasesPath(), 'app.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          email TEXT,
          password TEXT
        )
        ''');
      },
    );

    return _db!;
  }



  static Future<void> insertUser(UserModel user) async {
    final db = await database;

    await db.insert(
      'users',
      user.toMap(),
    );
  }

  static Future<UserModel?> login(String email, String password) async {
    final db = await database;

    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }

    return null;
  }
}