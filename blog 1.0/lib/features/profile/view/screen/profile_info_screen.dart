import 'package:blog/core/model/human_model.dart';
import 'package:blog/core/widget/human_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileInfoScreen extends ConsumerWidget {
  const ProfileInfoScreen({super.key, required this.viewmodel});
  final AsyncNotifierProvider<dynamic, HumanModel> viewmodel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(viewmodel)
        .when(
          data: (humanModel) => HumanModelDetailWidget(
            imagePath: humanModel.imagePath,
            name: humanModel.name,
            text: humanModel.text,
            isChange: false,
          ),
          error: (err, stack) =>
              Center(child: Text("Unexpected error occured $err -- $stack")),

          loading: () => Center(child: CircularProgressIndicator()),
        );
  }
}
