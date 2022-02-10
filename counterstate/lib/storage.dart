import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class CounterStorage {
  const CounterStorage({required this.filename});

  final String filename;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$filename');
  }

  Future<bool> writeCounter(int counter) async {
    try {
      final file = await _localFile;
      await file.writeAsString('$counter');
      return true;
    } catch (e) {
      // If encountering an error, return 0
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      if (kDebugMode) {
        print(e);
      }
      bool write_success = await writeCounter(0);
      if (write_success) {
        return 0;
      }
      return -1;
    }
  }
}
