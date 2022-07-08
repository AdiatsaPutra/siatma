import 'package:sqflite/sqflite.dart' as sql;

import '../models/user.dart';

class UserRepository {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        password TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'siatma.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<User> login(String name, String? password) async {
    final db = await UserRepository.db();

    final data = {'name': name, 'password': password};

    final id = await db.insert('users', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    final user = await db.query(
      'users',
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );

    final u = User.fromJson(user.first);
    return u;
  }

  // static Future<User> profile() async {
  //   final db = await UserRepository.db();

  //   final data = {'name': name, 'password': password};

  //   final id = await db.insert('users', data,
  //       conflictAlgorithm: sql.ConflictAlgorithm.replace);

  //   final user = await db.query(
  //     'users',
  //     where: "id = ?",
  //     whereArgs: [id],
  //     limit: 1,
  //   );

  //   final u = User.fromJson(user.first);
  //   return u;
  // }
}
