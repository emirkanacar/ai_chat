import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier {
  PageController? _pageController;

  PageController? get pageController {
    return _pageController;
  }

  void setPageController(PageController? pageController) {
    _pageController = pageController;

    notifyListeners();
  }

}