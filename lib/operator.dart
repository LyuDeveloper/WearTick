import 'dart:convert';
import 'dart:io';

import 'package:weartick/JsonDecode.dart';

void dirCreator(path) async {
    var dir = Directory(path);
    if (dir.existsSync()) {
      print("Directory $dir exists");
    } else {
      print("Directory $dir does not exist");
      await dir.create(recursive: true);
    }
  }

Future<File> fileWriter(localFile, jsonContext) async {
  final file = await localFile;

  // Write the file
  return file.writeAsString(jsonContext);
}

Future<String> fileReader(filePath) async {
  File file = File(filePath);
  final context = file.readAsString();
  return context;
}

ProjectModel projectJsonDecode(context) {
  Map<String, dynamic> projectMap = json.decode(context);
  var projectInfo = ProjectModel.fromJson(projectMap);
  return projectInfo;
}

