import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class LocalDatabase {
  LocalDatabase._();

  static Database? _db;

  static Future<Database> get localDatabase async {
    if (_db != null) {
      return _db!;
    }

    final dbPath = await sql.getDatabasesPath();

    _db = await sql.openDatabase(
      join(dbPath, "app_database.db"),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE profile_table(id TEXT PRIMARY KEY, name TEXT, text TEXT, image_file TEXT)",
        );

        await db.execute(
          "CREATE TABLE people_friends_table(id TEXT PRIMARY KEY, name TEXT, text TEXT, image_file TEXT)",
        );

        await db.execute(
          "CREATE TABLE people_enemies_table(id TEXT PRIMARY KEY, name TEXT, text TEXT, image_file TEXT)",
        );

        await db.execute(
          "CREATE TABLE people_acquaintances_table(id TEXT PRIMARY KEY, name TEXT, text TEXT, image_file TEXT)",
        );

        await db.execute(
          "CREATE TABLE people_others_table(id TEXT PRIMARY KEY, name TEXT, text TEXT, image_file TEXT)",
        );

        await db.insert("profile_table", {
          "id": "1",
          "name": "",
          "text": "",
          "image_file": "",
        });
      },
      version: 1,
    );

    return _db!;
  }
}
