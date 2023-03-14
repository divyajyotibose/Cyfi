import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:cyfi/pages/FileOperations.dart';
import 'package:cyfi/pages/MultiCall.dart';
import 'package:cyfi/pages/VirusTotal.dart';
import 'package:cyfi/pages/navbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cyfi/config/Palette.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import "package:csv/csv.dart";

class AbuseIPDB extends StatefulWidget {
  const AbuseIPDB({super.key});

  @override
  State<AbuseIPDB> createState() => _AbuseIPDBState();
}

class _AbuseIPDBState extends State<AbuseIPDB> {
  String? experiment = "";
  bool _visible = false;
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedFile;
  bool isLoading = false;
  List<List<dynamic>> op = [];
  late File csv_file;
  List<List<dynamic>> fields = [];
  int _selectedIndex = 0;
  Future<void> pickFile() async {
    try {
      result = null;
      result = await FilePicker.platform
          .pickFiles(type: FileType.any, allowMultiple: false);
      if (result != null) {
        _fileName = result!.files.first.name;
        pickedFile = result!.files.first;
        final fileToDisplay = File(pickedFile!.path.toString()).openRead();
        fields = await fileToDisplay
            .transform(utf8.decoder)
            .transform(const CsvToListConverter(eol: "\n"))
            .toList();
        print(fields);
      }
    } catch (e) {
      print(e);
    }
  }

  void _scaleDialog() {
    isLoading
        ? const Text("")
        : showGeneralDialog(
            context: context,
            pageBuilder: (ctx, a1, a2) {
              return Container();
            },
            transitionBuilder: (ctx, a1, a2, child) {
              var curve = Curves.easeInOut.transform(a1.value);
              return Transform.scale(
                scale: curve,
                child: AlertDialog(
                  title: const Text("Status"),
                  content: const Text("Your file has been downloaded"),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Ok",
                          style: TextStyle(color: Colors.red, fontSize: 17),
                        ))
                  ],
                ),
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "AbuseIPDB",
          style: TextStyle(color: Palette.light),
        ),
        titleTextStyle: Palette.mainTitle,
        backgroundColor: Palette.accentColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: Palette.light),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          decoration: BoxDecoration(
              color: Palette.accentSubColor,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/file_icon-removebg-preview.png",
                      width: width,
                      height: height * 0.2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      icon: Icon(
                        Icons.file_upload,
                        color: Palette.light,
                      ),
                      onPressed: () async {
                        pickFile();
                      },
                      label: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("Upload",
                            style: TextStyle(color: Palette.light)),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Palette.mainColor),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/file_icon-removebg-preview.png",
                        width: width,
                        height: height * 0.2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        icon: Icon(
                          Icons.file_download,
                          color: Palette.light,
                        ),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          MultiCall mc = MultiCall(file: fields);
                          isLoading = await mc.operation();
                          _scaleDialog();
                        },
                        label: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text("Download",
                              style: TextStyle(color: Palette.light)),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Palette.mainColor),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
      bottomNavigationBar: navbar(
        ind: _selectedIndex,
      ),
      backgroundColor: Palette.accentColor,
    );
  }
}
