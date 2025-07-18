import 'dart:io';

import 'package:blog/features/profile/model/profile_model.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;

Map<String, String?> profileModelToMap({required ProfileModel profileModel}) {
  return {
    "id": "1",
    "name": profileModel.name,
    "text": profileModel.text,
    "imagePath": profileModel.imagePath,
  };
}

ProfileModel mapToProfileModel(Map<String, Object?> map) {
  return ProfileModel(
    id: "1",
    text: map["text"] as String,
    name: map["name"] as String,
    imagePath: map["image_file"] as String,
  );
}

Future<String> copyImageToAppDocDir(File image) async {
  final appDocDir = await syspath.getApplicationDocumentsDirectory();
  final File copiedImage = await image.copy(
    "${appDocDir.path}/${path.basename(image.path)}",
  );

  return copiedImage.path;
}
