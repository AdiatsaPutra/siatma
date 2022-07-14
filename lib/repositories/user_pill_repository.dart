import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:si_atma/core/custom_exception.dart';
import 'package:si_atma/models/user_pill.dart';
import 'package:si_atma/models/user_pill_request.dart';
import 'package:si_atma/notification/notification_service.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/user.dart';

class UserPillRepository {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE Userpills (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        amount INTEGER,
        date TEXT,
        time TEXT,
        type INTEGER,
        isDone INTEGER
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'siatma2.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  ///CREATE
  static Future<Either<CustomException, void>> createUserPill(
      User u, UserPillRequest userPill) async {
    try {
      final db = await UserPillRepository.db();
      //times a day
      for (var t = 0; t < userPill.timePerDay; t++) {
        NotificationService()
            .scheduleNotifications(u, userPill, t * userPill.interval);
        //for how many days
        for (var i = 0; i < userPill.timeLasting; i++) {
          final data = {
            'name': userPill.name,
            'amount': userPill.amount,
            'date': DateFormat('yyyy-MM-dd').format(
              userPill.time.add(Duration(days: i)),
            ),
            'time': DateFormat('HH:mm').format(
              userPill.time.add(
                Duration(hours: t * userPill.interval),
              ),
            ),
            'type': userPill.type,
            'isDone': 0,
          };
          await db.insert('Userpills', data);
          debugPrint(data.toString());
        }
      }

      return const Right(null);
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  ///READ
  static Future<Either<CustomException, List<UserPill>>> getUserPill(
    String date,
  ) async {
    try {
      final db = await UserPillRepository.db();
      final userPill = await db.query(
        'Userpills',
        where: 'date = ?',
        whereArgs: [date],
      );
      final u = userPill.map((e) => UserPill.fromJson(e)).toList();
      return Right(u);
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  ///DELETE
  static Future<Either<CustomException, void>> deleteUserPill(int? id) async {
    try {
      final db = await UserPillRepository.db();

      final delete =
          await db.delete("Userpills", where: "id = ?", whereArgs: [id]);
      Logger().i(delete);
      return const Right(null);
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  static Future<Either<CustomException, void>> updateUserPill(
      int id, UserPill userPill) async {
    try {
      final db = await UserPillRepository.db();

      final data = {
        'name': userPill.name,
        'amount': userPill.amount,
        'date': userPill.date,
        'time': userPill.time,
        'type': userPill.type,
        'isDone': 1
      };

      await db.update('Userpills', data,
          where: "id = ?", whereArgs: [id]).then((value) => Logger().i(value));

      return const Right(null);
    } catch (e) {
      Logger().i(e);
      return Left(CustomException(e.toString()));
    }
  }
}
