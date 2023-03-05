
import 'dart:ffi';
import 'dart:io';

import 'package:cyfi/pages/FileOperations.dart';
import 'package:cyfi/pages/MultiCall.dart';
import 'package:cyfi/pages/VirusTotal.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cyfi/config/palette.dart';

class AbuseIPDB extends StatefulWidget {
  const AbuseIPDB({super.key});

  @override
  State<AbuseIPDB> createState() => _AbuseIPDBState();
}

class _AbuseIPDBState extends State<AbuseIPDB> {
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedFile;
  bool isLoading=false;
  File? fileToDisplay;
  Future<List<List<dynamic>>>? op;
  List<List<dynamic>>? forward_file;
  Future<dynamic>? csv_file;
  int _selectedIndex=0;
    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(index==1){
      Navigator.pushNamed(context,"/VirusTotal");

    }
    if(index==2){
      Navigator.pushNamed(context, "/");
    }
    else if(index==3){
      Navigator.pushNamed(context,"/search");
    }
  }
  Future<void> pickFile() async {
    try{
      setState(() {
        isLoading=true;
      });
      result=await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false
      );
      if(result!=null){
        _fileName=result!.files.first.name;
        pickedFile=result!.files.first;
        fileToDisplay=File(pickedFile!.path.toString());
        print("File name $_fileName");
      }

      setState(() {
        isLoading=false;
      });
    }
    catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width ;
    double height = MediaQuery. of(context). size. height;
    return  Scaffold(
      appBar: AppBar(
        title: Text("AbuseIPDB",style:TextStyle(color: palette.barTextColor), ),
        titleTextStyle: palette.mainTitle,
        backgroundColor: palette.barColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: palette.barTextColor),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        Column(
          children: [
            Image.asset("assets/file_icon-removebg-preview.png",width: width,height:height*0.2,),
            SizedBox(height: 10,),
            ElevatedButton.icon(
              icon: Icon(Icons.file_upload,color: Colors.black,),
              onPressed: () async {
                pickFile();
                FileOperations fop=FileOperations();
                op=(await fop.open(context,pickedFile)) as Future<List<List>>?;
                forward_file=await op;
              },
               label:Padding(padding: EdgeInsets.all(10),
               child: Text("Upload",style: TextStyle(color: palette.barTextColor)),
               ),
              style: TextButton.styleFrom(
                backgroundColor: palette.buttonColor
              ),
               ),
          ],
        ),
        Column(
        children: [
        Image.asset("assets/file_icon-removebg-preview.png",width: width,height:height*0.2,),
        SizedBox(height: 10,),
        ElevatedButton.icon(
          icon: Icon(Icons.file_download,color: Colors.black,),
          onPressed: (){
            MultiCall mc=MultiCall(file:forward_file);
            csv_file=mc.operation();
          },
           label:Padding(padding: EdgeInsets.all(10),
           child: Text("Download",style: TextStyle(color: palette.barTextColor)),
           ),
          style: TextButton.styleFrom(
            backgroundColor: palette.buttonColor
          ),
           ),
                     ],
                   ),
          
      ]),
      bottomNavigationBar:BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: palette.barColor,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/index-removebg-preview.png",width: 30,height: 30,),     
            label: "AbDB",      
            ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/vt_icon-removebg-preview.png",width: 30,height: 30,),     
            label: "VT",      
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search"
            ),            
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      ),
      backgroundColor: palette.bgColor,
    );
  }
}