import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:cyfi/pages/FileOperations.dart';
import 'package:cyfi/pages/MultiCall.dart';
import 'package:cyfi/pages/VirusTotal.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cyfi/config/palette.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import "package:csv/csv.dart";


class AbuseIPDB extends StatefulWidget {
  const AbuseIPDB({super.key});

  @override
  State<AbuseIPDB> createState() => _AbuseIPDBState();
}

class _AbuseIPDBState extends State<AbuseIPDB> {
  String? experiment="";
  bool _visible=false;
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedFile;
  bool isLoading = false;
  List<List<dynamic>> op=[];
  late File csv_file;
  List<List<dynamic>> fields=[];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.pushReplacementNamed(context, "/VirusTotal");
    }
    else if (index == 2) {
      Navigator.pushReplacementNamed(context, "/WIP");
    }
    else if (index == 3) {
      Navigator.pushReplacementNamed(context, "/search");
    }
  }

  Future<void> pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
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

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }
  void _scaleDialog() {
    showGeneralDialog(
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
        title: Text(
          "AbuseIPDB",
          style: TextStyle(color: palette.barTextColor),
        ),
        titleTextStyle: palette.mainTitle,
        backgroundColor: palette.barColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: palette.barTextColor),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
              icon: const Icon(
                Icons.file_upload,
                color: Colors.black,
              ),
              onPressed: () async {
                pickFile();
              },
              label: Padding(
                padding: const EdgeInsets.all(10),
                child: Text("Upload",
                    style: TextStyle(color: palette.barTextColor)),
              ),
              style: TextButton.styleFrom(backgroundColor: palette.buttonColor),
            ),
          ],
        ),
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
              icon: const Icon(
                Icons.file_download,
                color: Colors.black,
              ),
              onPressed: () async {
                MultiCall mc = MultiCall(file: fields);
                mc.operation();
                _scaleDialog();
              },
              label: Padding(
                padding: const EdgeInsets.all(10),
                child: Text("Download",
                    style: TextStyle(color: palette.barTextColor)),
              ),
              style: TextButton.styleFrom(backgroundColor: palette.buttonColor),
            ),

          ],
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: palette.barColor,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/index-removebg-preview.png",
              width: 30,
              height: 30,
            ),
            label: "AbDB",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/vt_icon-removebg-preview.png",
              width: 30,
              height: 30,
            ),
            label: "VT",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/wip-removebg-preview.png", width: 30, height: 30,),
            label: "WIP",
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.search,size: 30,), label: "Search"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      backgroundColor: palette.bgColor,
    );
  }

}
