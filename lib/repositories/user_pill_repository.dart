import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:si_atma/core/custom_exception.dart';
import 'package:si_atma/models/user_pill.dart';
import 'package:si_atma/models/user_pill_request.dart';
import 'package:sqflite/sqflite.dart' as sql;

class UserPillRepository {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE Userpills (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        amount INTEGER,
        date TEXT,
        time TEXT,
        type INTEGER,
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

  static Future<Either<CustomException, void>> createUserPill(
      UserPillRequest userPill) async {
    try {
      final db = await UserPillRepository.db();
      //times a day
      for (var t = 0; t < userPill.timePerDay; t++) {
        //for how many days
        for (var i = 0; i < userPill.timeLasting; i++) {
          final data = {
            'name': userPill.name,
            'amount': userPill.amount,
            'date': DateFormat('yyyy-MM-dd').format(
              userPill.time.add(Duration(days: i)),
            ),
            'time': DateFormat('HH:mm').format(
              userPill.time.add(Duration(hours: t)),
            ),
            'type': userPill.type,
          };
          await db.insert('Userpills', data);
        }
      }
      return const Right(null);
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

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
      Logger().i(userPill);
      final u = userPill.map((e) => UserPill.fromJson(e)).toList();
      return Right(u);
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}
