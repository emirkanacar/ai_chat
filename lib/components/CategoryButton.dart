import 'package:flutter/material.dart';

import '../helpers/functions.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    Key? key,
    required this.buttonText,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String buttonText;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 4, bottom: 4, right: 4, left: 0),
        decoration: BoxDecoration(
            color: isSelected ? const Color(0xff3f69ef).withOpacity(0.05) : Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.fromBorderSide(BorderSide(color: isSelected ? const Color(0xff3f69ef) : Theme.of(context).dividerColor))
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.only(top: 3, bottom: 3, right: 10, left: 10),
                child: Text(buttonText, style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: getFontSize(14, context).toDouble(),
                    color: isSelected ? const Color(0xff3f69ef) : Theme.of(context).textTheme.bodyLarge?.color
                ),),
              )
          ),
        ),
      ),
    );
  }
}
