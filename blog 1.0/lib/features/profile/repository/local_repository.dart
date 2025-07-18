import 'package:blog/core/data/local_database.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalRepository {
  Future<List<Map<String, Object?>>> get profileData async {
    final db = await LocalDatabase.localDatabase;

    return await db.query("profile_table");
  }

  Future<void> changeProfileData({
    required Map<String, String?> newProfileData,
  }) async {
    final db = await LocalDatabase.localDatabase;

    await db.update(
      "profile_table",
      newProfileData,
      where: "id = ?",
      whereArgs: ["1"],
    );
  }
}

final localRepository = Provider((ref) => LocalRepository());
