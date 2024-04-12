import 'package:ai_chat/components/BottomNavigation/BottomNavigationComponent.dart';
import 'package:ai_chat/constant/theme.dart';
import 'package:ai_chat/providers/SettingsProvider.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../constant/BottomAppBar.dart';
import 'BottomNavigation/BottomNavigationItem.dart';

class AppWrapper extends StatefulWidget {
  const AppWrapper({
    Key? key,
    required this.content
  }) : super(key: key);

  final Widget content;

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  SettingsProvider? _settingsProvider;

  @override
  void initState() {
    _settingsProvider = context.read<SettingsProvider>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _settingsProvider = context.watch<SettingsProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ]
            )
        ),
        child: SafeArea(
            bottom: false,
            child: widget.content
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const AppBottomBar()
    );
  }
}


