import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:si_atma/core/custom_exception.dart';
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

  static Future<Either<CustomException, User>> login(
      String name, String password) async {
    try {
      final db = await UserRepository.db();

      final data = {'name': name, 'password': password};

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      final id = sharedPreferences.getString('id');

      var userInitial = User(
        id: 0,
        name: '',
        password: '',
        createdAt: '',
      );

      if (id != null) {
        final user = await db.query(
          'users',
          where: "id = ?",
          whereArgs: [int.parse(id)],
          limit: 1,
        );
        final u = User.fromJson(user.first);
        userInitial = u;
      }

      final idResult = await db.insert('users', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);

      final user = await db.query(
        'users',
        where: "id = ?",
        whereArgs: [idResult],
        limit: 1,
      );
      final u = User.fromJson(user.first);

      userInitial = u;

      sharedPreferences.setString('id', u.id.toString());
      sharedPreferences.setString('name', u.name);
      sharedPreferences.setString('password', u.password);

      return Right(userInitial);
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  static Future<Either<CustomException, User>> profile() async {
    try {
      final db = await UserRepository.db();

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      final id = sharedPreferences.getString('id');

      final user = await db.query(
        'users',
        where: "id = ?",
        whereArgs: [int.parse(id!)],
        limit: 1,
      );

      final u = User.fromJson(user.first);

      return Right(u);
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}
