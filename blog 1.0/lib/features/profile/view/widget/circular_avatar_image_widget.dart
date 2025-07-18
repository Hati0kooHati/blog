import 'dart:io';

import 'package:blog/core/theme/theme.dart';
import 'package:flutter/material.dart';

class CircularAvatarImageWidget extends StatelessWidget {
  const CircularAvatarImageWidget({super.key, required this.imagePath});

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return imagePath != ""
        ? GestureDetector(
            child: Container(
              height: 200,
              width: 200,
              clipBehavior: Clip.hardEdge,
              decoration: AppTheme.imageFrameDecoration,
              child: Image.file(File(imagePath!)),
            ),
          )
        : Container(
            height: 200,
            width: 200,
            decoration: AppTheme.imageFrameDecoration,
          );
  }
}
