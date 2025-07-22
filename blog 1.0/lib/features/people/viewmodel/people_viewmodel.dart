import 'dart:async';
import 'dart:io';
import 'package:blog/core/model/human_model.dart';
import 'package:blog/core/utils/utils.dart';
import 'package:blog/features/people/repository/people_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Category { friends, enemies, acquaintances, others }

class PeopleViewmodel extends AsyncNotifier<Map<Category, List<HumanModel>>> {
  final PeopleRepository _peopleRepository;

  PeopleViewmodel(this._peopleRepository);

  @override
  FutureOr<Map<Category, List<HumanModel>>> build() async {
    final Map<Category, List<Map<String, Object?>>> data =
        await _peopleRepository.data;

    return {
      Category.friends: data[Category.friends]!
          .map((map) => mapToHumanModel(map))
          .toList(),
      Category.enemies: data[Category.enemies]!
          .map((map) => mapToHumanModel(map))
          .toList(),
      Category.acquaintances: data[Category.acquaintances]!
          .map((map) => mapToHumanModel(map))
          .toList(),
      Category.others: data[Category.others]!
          .map((map) => mapToHumanModel(map))
          .toList(),
    };
  }

  void newPeopleData({
    required Category category,
    required String text,
    required String name,
    required File? image,
  }) {
    state = AsyncLoading();

    final String tableName = categoryToTableName(category: category);

    final HumanModel newDataHumanModel = HumanModel(
      text: text,
      name: name,
      imagePath: image?.path ?? "",
    );

    final Map<String, String?> newDataMap = {
      "id": newDataHumanModel.id,
      "name": name,
      "text": text,
      "image_file": newDataHumanModel.imagePath,
    };

    _peopleRepository.newPeopleData(newData: newDataMap, tableName: tableName);

    final newState = Map.of(state.value!);

    newState[category] = [...newState[category]!, newDataHumanModel];

    state = AsyncData(Map.of(newState));
  }

  void changePeopleData({
    required Category category,
    required String text,
    required String name,
    required File? image,
    required HumanModel oldHumanModel,
  }) async {
    state = AsyncLoading();

    final String tableName = categoryToTableName(category: category);

    final Map<String, String> newDataMap = {
      "name": name,
      "text": text,
      "image_file": image?.path ?? oldHumanModel.imagePath,
    };

    state = await AsyncValue.guard(() async {
      _peopleRepository.changePeopleData(
        id: oldHumanModel.id,
        newData: newDataMap,
        tableName: tableName,
      );

      final Map<Category, List<HumanModel>> newState = Map.of(state.value!);

      final int index = newState[category]!.indexOf(oldHumanModel);

      newState[category]![index] = HumanModel(
        uid: oldHumanModel.id,
        text: text,
        name: name,
        imagePath: image?.path ?? oldHumanModel.imagePath,
      );

      return Map.of(newState);
    });
  }
}

final peopleViewmodel = AsyncNotifierProvider(() {
  return PeopleViewmodel(PeopleRepository());
});
