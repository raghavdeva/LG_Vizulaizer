import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class FileCreate{
  Future<File> createFile(String name, String content) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$name');
    file.writeAsStringSync(content);

    return file;
  }
}