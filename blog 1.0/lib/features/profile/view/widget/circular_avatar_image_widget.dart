import 'dart:io';
import 'package:flutter/material.dart';

class CircularAvatarImageWidget extends StatelessWidget {
  const CircularAvatarImageWidget({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: imagePath != "" ? FileImage(File(imagePath)) : null,
      maxRadius: 100,
      minRadius: 100,
    );
  }
}
