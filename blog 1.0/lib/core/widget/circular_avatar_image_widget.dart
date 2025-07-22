import 'dart:io';
import 'package:flutter/material.dart';

class CircularAvatarImageWidget extends StatelessWidget {
  const CircularAvatarImageWidget({
    super.key,
    required this.imagePath,
    required this.radius,
  });

  final String imagePath;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: imagePath != "" ? FileImage(File(imagePath)) : null,
      minRadius: radius,
    );
  }
}
