import 'package:hive/hive.dart';

part 'AppSettings.g.dart';

@HiveType(typeId: 3)
class AppSettings extends HiveObject {
  @HiveField(0)
  String theme;

  @HiveField(1)
  String language;

  @HiveField(2)
  int fontSize;

  @HiveField(3)
  bool notificationSettings;

  AppSettings({
    required this.theme,
    required this.language,
    required this.fontSize,
    required this.notificationSettings,
  });
}