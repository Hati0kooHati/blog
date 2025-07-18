import 'package:blog/core/theme/app_palette.dart';
import 'package:blog/features/people/view/widget/people_type_grid_item.dart';
import 'package:flutter/material.dart';

class PeopleTypeGridWidget extends StatelessWidget {
  const PeopleTypeGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(height: 30),

          Row(
            children: [
              PeopleTypeGridItemWidget(
                gradientColors: AppPalette.friendsGradientColors,
                splashColor: AppPalette.gridItemSplashColor,
              ),
              const SizedBox(width: 10),
              PeopleTypeGridItemWidget(
                gradientColors: AppPalette.enemiesGradientColors,
                splashColor: AppPalette.gridItemSplashColor,
              ),
            ],
          ),

          const SizedBox(height: 10),
          Row(
            children: [
              PeopleTypeGridItemWidget(
                gradientColors: AppPalette.acquaintancesGradientColors,
                splashColor: AppPalette.gridItemSplashColor,
              ),
              const SizedBox(width: 10),
              PeopleTypeGridItemWidget(
                gradientColors: AppPalette.otherGradientColorss,
                splashColor: AppPalette.gridItemSplashColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
