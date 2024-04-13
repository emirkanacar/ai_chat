import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../components/BottomNavigation/BottomNavigationComponent.dart';
import '../components/BottomNavigation/BottomNavigationItem.dart';
import '../providers/PageProvider.dart';

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({super.key});

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  @override
  Widget build(BuildContext context) {
    final pageProvider = context.watch<PageProvider>();

    return BottomNavigationComponent(
      bottomBarItem: [
        BottomNavigationItem(
          text: "",
          icon: Iconsax.home_2_outline,
          isSelected: pageProvider.pageController?.positions.isNotEmpty == true ? pageProvider.pageController?.page == 0 : true,
          onTap: () {
            pageProvider.pageController?.jumpToPage(0);
          },
        ),
        BottomNavigationItem(
          text: "",
          icon: Iconsax.messages_1_outline,
          isSelected: pageProvider.pageController?.positions.isNotEmpty == true ? pageProvider.pageController?.page == 1 : true,
          onTap: () {
            pageProvider.pageController?.jumpToPage(1);
          },
        ),
        BottomNavigationItem(
          text: "",
          icon: Iconsax.setting_2_outline,
          isSelected: pageProvider.pageController?.positions.isNotEmpty == true ? pageProvider.pageController?.page == 2 : true,
          onTap: () {
            pageProvider.pageController?.jumpToPage(2);
          },
        ),
      ],
    );
  }
}
