import 'package:blog/core/data/local_database.dart';
import 'package:blog/features/people/viewmodel/people_viewmodel.dart';

class PeopleRepository {
  Future<Map<Category, List<Map<String, Object?>>>> get data async {
    final db = await LocalDatabase.localDatabase;

    return {
      Category.friends: await db.query("people_friends_table"),
      Category.enemies: await db.query("people_enemies_table"),
      Category.acquaintances: await db.query("people_acquaintances_table"),
      Category.others: await db.query("people_others_table"),
    };
  }

  void newPeopleData({
    required Map<String, String?> newData,
    required String tableName,
  }) async {
    final db = await LocalDatabase.localDatabase;

    await db.insert(tableName, newData);
  }

  void changePeopleData({
    required String tableName,
    required String id,
    required Map<String, String> newData,
  }) async {
    final db = await LocalDatabase.localDatabase;

    await db.update(tableName, newData, where: "id = ?", whereArgs: [id]);
  }
}
