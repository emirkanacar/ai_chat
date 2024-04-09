
import 'package:ai_chat/models/AppSettings.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsProvider extends ChangeNotifier {
  AppSettings? _appSettings;

  AppSettings? get appSettings {
    return _appSettings;
  }

  void setAppSettings(AppSettings? settings) {
    _appSettings = settings;

    notifyListeners();
  }

  void setLanguage(String language) {
    _appSettings?.language = language;
    _updateLocalSettings(_appSettings);

    notifyListeners();
  }

  void setTheme(String theme) {
    _appSettings?.theme = theme;
    _updateLocalSettings(_appSettings);

    notifyListeners();
  }

  void setNotification(bool notification) {
    _appSettings?.notificationSettings = notification;
    _updateLocalSettings(_appSettings);

    notifyListeners();
  }

  void setFontSize(int size) {
    _appSettings?.fontSize = size;
    _updateLocalSettings(_appSettings);
    
    notifyListeners();
  }

  Future<void> _updateLocalSettings(AppSettings? settings) async {
    await Hive.box("app").put("settings", settings);

    _appSettings = settings;
  }
}