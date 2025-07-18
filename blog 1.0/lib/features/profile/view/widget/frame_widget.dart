import 'package:blog/core/theme/theme.dart';
import 'package:flutter/material.dart';

class FrameWidget extends StatelessWidget {
  const FrameWidget({
    super.key,
    required this.title,
    required this.text,
    required this.height,
    required this.width,
  });

  final String title;
  final String text;

  final double height;
  final double width;

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
            child: title == "Name" ? Center(child: Text(text)) : Text(text),
          ),
        ],
      ),
    );
  }
}
