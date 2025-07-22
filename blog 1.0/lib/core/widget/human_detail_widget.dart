import 'dart:io';

import 'package:blog/core/provider/picked_image_provider.dart';
import 'package:blog/core/widget/change_frame_widget.dart';
import 'package:blog/core/widget/circular_avatar_image_widget.dart';
import 'package:blog/core/widget/frame_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HumanModelDetailWidget extends ConsumerWidget {
  final String imagePath;
  final String name;
  final String text;
  final bool isChange;

  final TextEditingController? nameController;
  final TextEditingController? descriptionController;
  final Future<File?> Function()? pickImage;

  const HumanModelDetailWidget({
    super.key,
    required this.imagePath,
    required this.name,
    required this.text,
    required this.isChange,
    this.descriptionController,
    this.nameController,
    this.pickImage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: isChange
              ? [
                  Stack(
                    children: [
                      CircularAvatarImageWidget(
                        imagePath: imagePath,
                        radius: 100,
                      ),
                      Positioned(
                        top: 10,
                        right: 90,
                        child: IconButton(
                          onPressed: () async {
                            ref.watch(pickedImageProvider.notifier).state =
                                await pickImage!();
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ChangeFrameWidget(
                    title: "Name",
                    text: name,
                    height: 50,
                    width: 170,
                    textEditingController: nameController!,
                  ),

                  const SizedBox(height: 20),

                  ChangeFrameWidget(
                    title: "Description",
                    text: text,
                    height: 400,
                    width: double.infinity,
                    textEditingController: descriptionController!,
                  ),
                ]
              : [
                  CircularAvatarImageWidget(imagePath: imagePath, radius: 100),
                  const SizedBox(height: 20),
                  FrameWidget(
                    title: "Name",
                    text: name,
                    height: 50,
                    width: 170,
                  ),

                  const SizedBox(height: 20),

                  FrameWidget(
                    title: "Description",
                    text: text,
                    height: 400,
                    width: double.infinity,
                  ),
                ],
        ),
      ),
    );
  }
}
