import 'package:ai_chat/providers/PageProvider.dart';
import 'package:ai_chat/views/Chat/ChatsScreen.view.dart';
import 'package:ai_chat/views/HomeScreen.view.dart';
import 'package:ai_chat/views/SettingsScreen.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageProvider? pageProvider;
  final PageController pageController = PageController();
  int selectedPage = 0;

  @override
  void initState() {
    pageProvider = context.read<PageProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        pageProvider?.setPageController(pageController);
      }
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  onPageChange(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    pageProvider = context.watch<PageProvider>();

    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        HomeScreen(),
        ChatsScreen(),
        SettingsScreen()
      ],
      onPageChanged: (index) {
        onPageChange(index);
      },
    );
  }
}
