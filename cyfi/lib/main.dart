import 'package:cyfi/pages/AbuseIPDB.dart';
import 'package:cyfi/pages/SearchDB.dart';
import 'package:cyfi/pages/VirusTotal.dart';
import 'package:cyfi/pages/WhatsMyIP.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';

Future<void> main() async {

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/search',
    routes: {
      '/AbuseIPDB': (context) => const AbuseIPDB(),
      '/search': (context) => const SearchDB(),
      "/VirusTotal": (context) => const VirusTotal(),
      "/WIP":(context)=>const WhatsMyIP(),
    },
  ));
}
