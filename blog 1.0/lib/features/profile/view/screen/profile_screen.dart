import 'package:blog/features/profile/view/widget/circular_avatar_image_widget.dart';
import 'package:blog/features/profile/view/widget/frame_widget.dart';
import 'package:blog/features/profile/viewmodel/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(profileViewmodel)
        .when(
          data: (profileModel) => SingleChildScrollView(
            child: Column(
              children: [
                CircularAvatarImageWidget(imagePath: profileModel.imagePath),
                const SizedBox(height: 20),
                FrameWidget(
                  title: "Name",
                  text: profileModel.name,
                  height: 30,
                  width: 170,
                ),
                const SizedBox(height: 20),
                FrameWidget(
                  title: "Description",
                  text: profileModel.text,
                  height: 400,
                  width: double.infinity,
                ),
              ],
            ),
          ),
          error: (err, stack) =>
              Center(child: Text("Unexpected error occured $err -- $stack")),

          loading: () => Center(child: CircularProgressIndicator()),
        );
  }
}
