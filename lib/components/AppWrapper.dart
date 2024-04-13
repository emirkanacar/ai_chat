import 'package:flutter/material.dart';

import '../constant/BottomAppBar.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

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


