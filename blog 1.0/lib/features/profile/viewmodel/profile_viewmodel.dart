import 'dart:async';
import 'dart:io';

import 'package:blog/core/utils/utils.dart';
import 'package:blog/features/profile/model/profile_model.dart';
import 'package:blog/features/profile/repository/local_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewmodel extends AsyncNotifier<ProfileModel> {
  late final LocalRepository _localRepository;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  FutureOr<ProfileModel> build() async {
    _localRepository = ref.watch(localRepository);
    final data = await _localRepository.profileData;

    return mapToProfileModel(data[0]);
  }

  void changeProfileData({String? text, String? name, File? image}) async {
    state = AsyncLoading();

    String? newImagePath;

    if (image != null) {
      newImagePath = await copyImageToAppDocDir(image);
    }

    final Map<String, String?> newProfileData = {
      "id": "1",
      "name": name ?? state.value!.name,
      "text": text ?? state.value!.text,
      "image_file": newImagePath ?? state.value!.imagePath,
    };

    await _localRepository.changeProfileData(newProfileData: newProfileData);

    state = AsyncData(mapToProfileModel(newProfileData));
  }

  Future<File?> pickImage() async {
    final pickedImage = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedImage == null) {
      return null;
    }

    return File(pickedImage.path);
  }
}

final profileViewmodel = AsyncNotifierProvider(ProfileViewmodel.new);
