import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

Future<String> saveFile(File file, String fileName) async {
  Directory docDirectory = await getApplicationDocumentsDirectory();

  String ext = file.path.split(".").last;

  File newFile = File(path.join(docDirectory.path, path.basename("$fileName.$ext")));
  var bytes = await file.readAsBytes();

  await newFile.writeAsBytes(bytes);

  return newFile.path;
}