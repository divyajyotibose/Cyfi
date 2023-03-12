import "dart:convert";
import "package:csv/csv.dart";
import "package:http/http.dart";
import 'dart:io';
import 'package:path_provider/path_provider.dart';
// import "package:firebase_storage/firebase_storage.dart";
import 'package:permission_handler/permission_handler.dart';

class MultiCall {
  List<List<dynamic>> file;
  MultiCall({required this.file});
  static String apikey1 =
      "b08b9dd59b34d8e52895bba9e0e0ad715172622d636d2da74645256449991bbbaa1bacbb81fa9a32";

  Future<String> get _localpath async {
    const directory = '/storage/emulated/0/Download';

    return directory;
  }
  Future<File> get _localFile async {
    String path=await _localpath;
    return File('$path/logs.csv');
  }
  Future<void> operation() async {
    int i = 0;
    file[0].add("Public");
    file[0].add("ISP");
    file[0].add("Domain");
    file[0].add("Country");
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Key': apikey1
    };
    for (var l in file) {
      if (i != 0) {
        Map<String, String> querystring = {
          'ipAddress': l[0],
          'maxAgeInDays': '90'
        };
        final Uri endpoint1 =
        Uri.https("api.abuseipdb.com", "/api/v2/check", querystring);
        Response response = await get(endpoint1, headers: headers);
        Map res = jsonDecode(response.body);
        Map data = await res["data"];
        l.add(data["isPublic"]);
        l.add(data["isp"].toString());
        l.add(data["domain"].toString());
        l.add(data["countryCode"]);
      } else {
        i += 1;
      }
    }
    print(file);
    final status=Permission.storage.request();
    if(await status.isGranted) {
      final output = await _localFile;
      String csv = const ListToCsvConverter().convert(file, eol: "\n");
      print(csv);
      output.writeAsString(csv);
      print(output.path);
    }
  }
}
