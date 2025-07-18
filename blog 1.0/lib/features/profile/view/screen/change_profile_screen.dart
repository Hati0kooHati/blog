import 'dart:io';

import 'package:blog/core/theme/theme.dart';
import 'package:blog/features/profile/view/widget/change_frame_widget.dart';
import 'package:blog/features/profile/view/widget/circular_avatar_image_widget.dart';
import 'package:blog/features/profile/viewmodel/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangeProfileScreen extends ConsumerStatefulWidget {
  const ChangeProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ChangeProfileScreenState();
  }
}

class _ChangeProfileScreenState extends ConsumerState<ChangeProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  File? pickedImage;

  @override
  void initState() {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Change profile", style: AppTheme.appBarTitleStyle),
          actions: [
            IconButton(
              onPressed: () {
                ref
                    .watch(profileViewmodel.notifier)
                    .changeProfileData(
                      image: pickedImage,
                      name: _nameController.text,
                      text: _descriptionController.text,
                    );
                Navigator.pop(context);
              },
              icon: Icon(Icons.save),
            ),
          ],
        ),
        body: ref
            .watch(profileViewmodel)
            .when(
              data: (profileModel) {
                _nameController.text = profileModel.name;
                _descriptionController.text = profileModel.text;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircularAvatarImageWidget(
                            imagePath: pickedImage != null
                                ? pickedImage!.path
                                : profileModel.imagePath,
                          ),
                          Positioned(
                            top: 17,
                            right: 17,
                            child: IconButton(
                              onPressed: () async {
                                pickedImage = await ref
                                    .watch(profileViewmodel.notifier)
                                    .pickImage();
                                setState(() {});
                              },
                              icon: Icon(Icons.edit),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ChangeFrameWidget(
                        title: "Name",
                        text: profileModel.name,
                        height: 50,
                        width: 170,
                        textEditingController: _nameController,
                      ),
                      const SizedBox(height: 20),
                      ChangeFrameWidget(
                        title: "Description",
                        text: profileModel.text,
                        height: 400,
                        width: double.infinity,
                        textEditingController: _descriptionController,
                      ),
                    ],
                  ),
                );
              },
              error: (err, stack) => Center(
                child: Text("Unexpected error occured $err -- $stack"),
              ),

              loading: () => Center(child: CircularProgressIndicator()),
            ),
      ),
    );
  }
}
