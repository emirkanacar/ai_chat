import 'package:ai_chat/providers/SettingsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'BottomNavigationItem.dart';

class BottomNavigationComponent extends StatelessWidget {
  const BottomNavigationComponent({
    super.key,
    required this.bottomBarItem,
    this.backgroundColor = Colors.white
  });

  static double bottomBarHeight = 100;
  final List<BottomNavigationItem> bottomBarItem;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    SettingsProvider _settingsProvider = context.watch<SettingsProvider>();

    return Container(
      height: 84,
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Color(0xFF282828),
          border: Border(
              top: BorderSide(color: _settingsProvider.appSettings?.theme == "dark" ? Colors.white24 : Color(0xFFC9C9C9))
          )
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF282828),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: bottomBarItem,
        ),
      ),
    );
  }
}
