import 'dart:io';

import 'package:blog/core/theme/app_palette.dart';
import 'package:blog/core/theme/theme.dart';
import 'package:blog/features/people/view/screen/people_screen.dart';
import 'package:blog/features/profile/view/screen/change_profile_screen.dart';
import 'package:blog/features/profile/view/screen/profile_screen.dart';
import 'package:blog/features/profile/viewmodel/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final List<Widget> screens = [PeopleScreen(), ProfileScreen()];
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
                      builder: (context) => ChangeProfileScreen(
                        pickImage: () =>
                            ref.watch(profileViewmodel.notifier).pickImage(),
                        changeProfileData: ({String? text, String? name, File? image}) => ref.watch(profileViewmodel.notifier).changeProfileData(image: image, name: name, text: text),
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
