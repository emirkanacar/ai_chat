import 'package:ai_chat/providers/SettingsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.iconSize,
    this.isLoading
  }) : super(key: key);

  final IconData icon;
  final void Function() onPressed;
  final double? iconSize;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    SettingsProvider _settingsProvider = context.watch<SettingsProvider>();

    return IconButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFF282828),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          side: BorderSide(width: 1, color: _settingsProvider.appSettings?.theme == "dark" ? Colors.white24 : const Color(0xFFC9C9C9))
      ),
      onPressed: isLoading != null && isLoading == true ? null : onPressed,
      icon: isLoading != null && isLoading == true ?
        SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white60,
          ),
        ) :
        Icon(icon, color: Colors.white, size: iconSize ?? 24,) ,
    );
  }
}
