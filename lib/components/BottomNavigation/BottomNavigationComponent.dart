import 'package:flutter/material.dart';
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
    return Container(
      height: 84,
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        border:  Border(
          top: BorderSide(color: Theme.of(context).dividerColor)
        )
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
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
