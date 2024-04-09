import 'package:flutter/material.dart';

class BottomNavigationItem extends StatelessWidget {
  const BottomNavigationItem({
    super.key,
    this.iconSize = 28,
    this.textSize = 18,
    required this.text,
    required this.icon,
    required this.isSelected,
    this.onTap,
  });

  final double iconSize;
  final double textSize;
  final String text;
  final IconData icon;
  final double itemBottomPadding = 3.0;
  final double containerAllItemPadding = 10.0;
  final double containerAllItemMargin = 2.0;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Container(
            height: double.infinity,
            margin: EdgeInsets.all(containerAllItemMargin),
            padding: EdgeInsets.all(containerAllItemPadding),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF282828) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.only(bottom: itemBottomPadding),
              child: Icon(
                icon,
                size: iconSize,
                color: isSelected ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
