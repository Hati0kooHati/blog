import 'package:blog/core/theme/theme.dart';
import 'package:flutter/material.dart';

class ChangeFrameWidget extends StatelessWidget {
  const ChangeFrameWidget({
    super.key,
    required this.title,
    required this.text,
    required this.height,
    required this.width,

    required this.textEditingController,
  });

  final String title;
  final String text;

  final double height;
  final double width;

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(title),
          const SizedBox(height: 5),
          Container(
            height: height,
            width: width,
            decoration: AppTheme.frameDecoration,
            child: title == "Name"
                ? Center(
                    child: TextFormField(
                      controller: textEditingController,
                      textAlignVertical: TextAlignVertical.top,
                      
                    ),
                  )
                : TextFormField(
                    controller: textEditingController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 1,
                  ),
          ),
        ],
      ),
    );
  }
}
