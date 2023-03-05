import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import "package:csv/csv.dart";
class FileOperations{

  Future<List<List<dynamic>>> open(BuildContext context,PlatformFile? file) async {
    PlatformFile f;
    List<List<dynamic>> data=[];
    if(file!=null){
    f=file;
    var res=await DefaultAssetBundle.of(context).loadString(f.path.toString());
    data= CsvToListConverter().convert(res,eol: "\n");
    }
    print(data);
    return data;
  }
  
}