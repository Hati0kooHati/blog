import 'dart:async';
import 'dart:io';

import 'package:blog/core/service/image_service.dart';
import 'package:blog/core/utils/utils.dart';
import 'package:blog/features/profile/model/profile_model.dart';
import 'package:blog/features/profile/repository/local_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileViewmodel extends AsyncNotifier<ProfileModel> {
  final LocalRepository _localRepository;
  final ImageService _imageService;

  File? pickedImage;

  ProfileViewmodel(this._localRepository, this._imageService);

  @override
  FutureOr<ProfileModel> build() async {
    final data = await _localRepository.profileData;

    return mapToProfileModel(data[0]);
  }

  void changeProfileData({String? text, String? name, File? image}) async {
    state = AsyncLoading();

    String? newImagePath;

    if (image != null) {
      newImagePath = await _imageService.copyImageToAppDocDir(image);
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
    return await _imageService.pickImage();
  }
}

final profileViewmodel = AsyncNotifierProvider(
  () => ProfileViewmodel(LocalRepository(), ImageService()),
);

final pickedImageProvider = StateProvider<File?>((ref) => null);
