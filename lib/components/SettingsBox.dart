import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../helpers/functions.dart';

class SettingsBox extends StatelessWidget {
  const SettingsBox({
    Key? key,
    required this.onTap,
    required this.title,
    required this.description,
    required this.icon,
    this.isFirst,
    this.isLast
  }): super(key: key);

  final void Function() onTap;
  final String title;
  final String description;
  final IconData icon;
  final bool? isFirst;
  final bool? isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          border: isFirst == true ? Border(
            bottom: BorderSide(width: 1.0, color: Theme.of(context).dividerColor),
            top: BorderSide(width: 1.0, color: Theme.of(context).dividerColor),
            right: BorderSide(width: 1.0, color: Theme.of(context).dividerColor),
            left: BorderSide(width: 1.0, color: Theme.of(context).dividerColor),
          ) : isLast == true ? Border(
            bottom: BorderSide(width: 1.0, color: Theme.of(context).dividerColor),
            right: BorderSide(width: 1.0, color: Theme.of(context).dividerColor),
            left: BorderSide(width: 1.0, color: Theme.of(context).dividerColor),
          ) : Border(
            right: BorderSide(width: 1.0, color: Theme.of(context).dividerColor),
            left: BorderSide(width: 1.0, color: Theme.of(context).dividerColor),
            bottom: BorderSide(width: 1.0, color: Theme.of(context).dividerColor),
          ),
          borderRadius: isFirst == true ? const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)) : isLast == true ? const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)) : BorderRadius.zero,
        ),
        child: Material(
          borderRadius: isFirst == true ? const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)) : isLast == true ? const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)) : BorderRadius.zero,
          color: Colors.transparent,
          child: InkWell(
              borderRadius: isFirst == true ? const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)) : isLast == true ? const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)) : BorderRadius.zero,
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Icon(icon, size: 28, color: Theme.of(context).textTheme.bodyLarge?.color,),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 10, right: 20, top: 0, bottom: 0),
                                child: Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: getFontSize(16, context).toDouble(),
                                ),)
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 10, right: 20, top: 0),
                                child: Text(description, style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: getFontSize(14, context).toDouble(),
                                  )
                                )
                            ),
                          ],
                        )
                      ],
                    ),
                    Icon(HeroIcons.chevron_right, size: 24, color: Theme.of(context).textTheme.bodyLarge?.color)
                  ],
                ),
              )
          ),
        )
    );
  }
}
