import 'dart:io';

import 'package:blog/core/theme/theme.dart';
import 'package:blog/features/profile/view/widget/change_frame_widget.dart';
import 'package:blog/features/profile/view/widget/circular_avatar_image_widget.dart';
import 'package:blog/features/profile/viewmodel/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangeProfileScreen extends ConsumerStatefulWidget {
  final Future<File?> Function() pickImage;
  final void Function({String? text, String? name, File? image})
  changeProfileData;

  const ChangeProfileScreen({
    super.key,
    required this.pickImage,
    required this.changeProfileData,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ChangeProfileScreenState();
  }
}

class _ChangeProfileScreenState extends ConsumerState<ChangeProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    File? pickedImage = ref.watch(pickedImageProvider);
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Change profile", style: AppTheme.appBarTitleStyle),
          actions: [
            IconButton(
              onPressed: () {
                widget.changeProfileData(
                  image: pickedImage,
                  name: _nameController.text,
                  text: _descriptionController.text,
                );

                ref.watch(pickedImageProvider.notifier).state = null;
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
                if (_nameController.text == "" &&
                    _descriptionController.text == "") {
                  _nameController.text = profileModel.name;
                  _descriptionController.text = profileModel.text;
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircularAvatarImageWidget(
                            imagePath: pickedImage != null
                                ? pickedImage.path
                                : profileModel.imagePath,
                          ),
                          Positioned(
                            top: 17,
                            right: 17,
                            child: IconButton(
                              onPressed: () async {
                                ref.watch(pickedImageProvider.notifier).state =
                                    await widget.pickImage();
                              },
                              icon: Icon(Icons.edit, color: Colors.white),
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
