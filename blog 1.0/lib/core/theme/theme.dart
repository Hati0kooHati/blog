import 'package:flutter/material.dart';

class AppTheme {
  static final TextStyle appBarTitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 30,
  );
  static final BoxDecoration peopleTypeGridItemDecoration = BoxDecoration(
    gradient: LinearGradient(colors: []),
    borderRadius: BorderRadius.circular(16),
  );
  static final BoxDecoration imageFrameDecoration = BoxDecoration(
    border: Border.all(color: Colors.grey, width: 3),
    borderRadius: BorderRadius.circular(100),
  );

  static final BoxDecoration frameDecoration = BoxDecoration(
    border: Border.all(color: Colors.grey, width: 3),
  );
}
