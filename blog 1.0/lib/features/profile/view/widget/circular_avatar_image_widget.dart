import 'dart:io';

import 'package:blog/core/theme/theme.dart';
import 'package:flutter/material.dart';

class CircularAvatarImageWidget extends StatelessWidget {
  const CircularAvatarImageWidget({super.key, required this.imagePath});

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return imagePath != ""
        ? CircleAvatar(
            backgroundImage: FileImage(File(imagePath!)),
            maxRadius: 100,
            minRadius: 100,
          )
        : Container(
            height: 200,
            width: 200,
            decoration: AppTheme.imageFrameDecoration,
          );
  }
}
