import 'dart:io';

import 'package:ai_chat/providers/SettingsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

Future<String> saveFile(File file, String fileName) async {
  Directory? docDirectory;

  if (Platform.isIOS) {
    docDirectory = await getApplicationDocumentsDirectory();
  } else {
    docDirectory = await getDownloadsDirectory();
  }

  String ext = file.path.split(".").last;

  File newFile = File(path.join(docDirectory!.path, path.basename("$fileName.$ext")));
  var bytes = await file.readAsBytes();

  await newFile.writeAsBytes(bytes);

  return newFile.path;
}

num getFontSize(num fontSize, BuildContext buildContext) {
  SettingsProvider settingsProvider = buildContext.read<SettingsProvider>();

  num diffFromBase = 16 - fontSize;
  num settingsFontSize = settingsProvider.appSettings?.fontSize ?? 16;

  if (diffFromBase > 0) {
    return settingsFontSize - diffFromBase;
  } else {
    return settingsFontSize + (diffFromBase * -1) * 0.8;
  }


}