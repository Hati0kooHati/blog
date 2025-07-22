import 'dart:io';

import 'package:blog/core/model/human_model.dart';
import 'package:blog/core/provider/picked_image_provider.dart';
import 'package:blog/core/theme/theme.dart';
import 'package:blog/core/widget/human_detail_widget.dart';
import 'package:blog/features/profile/viewmodel/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangeHumanInfoScreen extends ConsumerStatefulWidget {
  final Future<File?> Function() pickImage;
  final void Function({required String text, required String name, File? image})
  changeHumanData;
  final String title;
  final AsyncNotifierProvider<ProfileViewmodel, HumanModel>? viewmodel;

  const ChangeHumanInfoScreen({
    super.key,
    required this.pickImage,
    required this.changeHumanData,
    required this.title,
    this.viewmodel,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ChangeProfileScreenState();
  }
}

class _ChangeProfileScreenState extends ConsumerState<ChangeHumanInfoScreen> {
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
          title: Text(widget.title, style: AppTheme.appBarTitleStyle),
          actions: [
            IconButton(
              onPressed: () {
                widget.changeHumanData(
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
        body: widget.viewmodel != null
            ? ref
                  .watch(widget.viewmodel!)
                  .when(
                    data: (humanModel) {
                      if (_nameController.text == "" &&
                          _descriptionController.text == "") {
                        _nameController.text = humanModel.name;
                        _descriptionController.text = humanModel.text;
                      }

                      return SingleChildScrollView(
                        child: HumanModelDetailWidget(
                          imagePath: humanModel.imagePath,
                          name: humanModel.name,
                          text: humanModel.text,
                          descriptionController: _descriptionController,
                          nameController: _nameController,
                          isChange: true,
                          pickImage: widget.pickImage,
                        ),
                      );
                    },
                    error: (err, stack) => Center(
                      child: Text("Unexpected error occured $err -- $stack"),
                    ),

                    loading: () => Center(child: CircularProgressIndicator()),
                  )
            : HumanModelDetailWidget(
                imagePath: "",
                name: "",
                text: "",
                descriptionController: _descriptionController,
                nameController: _nameController,
                isChange: true,
                pickImage: widget.pickImage,
              ),
      ),
    );
  }
}
