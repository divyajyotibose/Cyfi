import 'package:cyfi/pages/AbuseIPDB.dart';
import 'package:cyfi/pages/Home.dart';
import 'package:cyfi/pages/SearchDB.dart';
import 'package:cyfi/pages/VirusTotal.dart';
import 'package:cyfi/pages/searchResults.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/':(context)=>Home(),
      '/AbuseIPDB':(context)=>AbuseIPDB(),
      '/search':(context)=>SearchDB(),
      "/VirusTotal":(context)=>VirusTotal(),
    },
  
  ));
}



