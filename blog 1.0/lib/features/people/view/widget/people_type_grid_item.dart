import 'package:blog/core/theme/theme.dart';
import 'package:flutter/material.dart';

class PeopleTypeGridItemWidget extends StatelessWidget {
  const PeopleTypeGridItemWidget({
    super.key,
    required this.gradientColors,
    required this.splashColor,
  });

  final List<Color> gradientColors;
  final Color splashColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {},
      splashColor: splashColor,
      child: Container(
        height: 300,
        width: 190,
        decoration: AppTheme.peopleTypeGridItemDecoration.copyWith(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
