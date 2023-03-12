import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import "package:csv/csv.dart";

class FileOperations {
  Future<List<List<dynamic>>> open(
      BuildContext context, PlatformFile? file) async {
    String path = file!.path.toString();
    print(path);
    var res = await DefaultAssetBundle.of(context).loadString(path);
    List<List<dynamic>> data = CsvToListConverter().convert(res, eol: "\n");
    return data;
  }
}
