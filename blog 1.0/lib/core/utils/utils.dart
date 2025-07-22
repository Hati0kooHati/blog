import 'package:blog/core/model/human_model.dart';
import 'package:blog/features/people/viewmodel/people_viewmodel.dart';

Map<String, String?> humanModelToMap({required HumanModel profileModel}) {
  return {
    "id": "1",
    "name": profileModel.name,
    "text": profileModel.text,
    "imagePath": profileModel.imagePath,
  };
}

HumanModel mapToHumanModel(Map<String, Object?> map) {
  return HumanModel(
    uid: "1",
    text: map["text"] as String,
    name: map["name"] as String,
    imagePath: map["image_file"] as String,
  );
}

String categoryToTableName({required Category category}) {
  return "people_${category.name}_table";
}
