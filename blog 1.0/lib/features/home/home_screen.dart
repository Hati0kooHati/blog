import 'dart:io';

import 'package:blog/core/theme/app_palette.dart';
import 'package:blog/core/theme/theme.dart';
import 'package:blog/features/people/view/screen/people_category_screen.dart';
import 'package:blog/core/screen/change_human_info_screen.dart';
import 'package:blog/features/profile/view/screen/profile_info_screen.dart';
import 'package:blog/features/profile/viewmodel/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final List<Widget> screens = [
    PeopleCategoryScreen(),
    ProfileInfoScreen(viewmodel: profileViewmodel),
  ];
  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          screenIndex == 0 ? "people" : "profile",
          style: AppTheme.appBarTitleStyle,
        ),
        actions: [
          screenIndex == 0
              ? IconButton(onPressed: () {}, icon: Icon(Icons.add, size: 40))
              : IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeHumanInfoScreen(
                        pickImage: () =>
                            ref.watch(profileViewmodel.notifier).pickImage(),
                        changeHumanData:
                            ({String? text, String? name, File? image}) => ref
                                .watch(profileViewmodel.notifier)
                                .changeProfileData(
                                  image: image,
                                  name: name,
                                  text: text,
                                ),
                        title: "Change profile",
                      ),
                    ),
                  ),
                  icon: Icon(Icons.edit, size: 28),
                ),
        ],
      ),
      body: screens[screenIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppPalette.selectedItemColor,
        currentIndex: screenIndex,
        onTap: (int newIndex) {
          setState(() {
            screenIndex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: "People",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
