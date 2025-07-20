
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:image_picker/image_picker.dart';

class ImageService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<String> copyImageToAppDocDir(File image) async {
    final appDocDir = await syspath.getApplicationDocumentsDirectory();
    final File copiedImage = await image.copy(
      "${appDocDir.path}/${path.basename(image.path)}",
    );

    return copiedImage.path;
  }

  Future<File?> pickImage() async {
    final pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) {
      return null;
    }

    return File(pickedImage.path);
  }
}
