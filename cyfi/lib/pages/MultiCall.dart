import "dart:convert";
import "package:csv/csv.dart";
import "package:http/http.dart";
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MultiCall {
  List<List<dynamic>> file;
  MultiCall({required this.file});
  static String apikey1 ="b08b9dd59b34d8e52895bba9e0e0ad715172622d636d2da74645256449991bbbaa1bacbb81fa9a32";
  static String apikey2="3134e3908a8322f3ed85a13c0d8280df626917720d61df64955b49662292ac77";
  static String apikey3="f9d2272a01b3aa63a382f26e6cd71651";
  Future<String> get _localpath async {
    const directory = '/storage/emulated/0/Download';

    return directory;
  }
  Future<File> get _localFile async {
    String path=await _localpath;
    return File('$path/logs.csv');
  }
  Future<bool> operation() async {
    int i = 0;
    file[0].add("Public");
    file[0].add("ISP");
    file[0].add("Domain");
    file[0].add("Country");
    file[0].add("AbuseIPDB Score");
    file[0].add("VirusTotal Score");
    file[0].add("WhatsMyIP Score");
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Key': apikey1
    };
    for (var l in file) {
      if (i != 0) {
        Map<String, String> querystring = {
          'ipAddress': l[0],
          'maxAgeInDays': l[1].toString()
        };
        final Uri endpoint1 =Uri.https("api.abuseipdb.com", "/api/v2/check", querystring);
        Response response = await get(endpoint1, headers: headers);
        Map res = jsonDecode(response.body);
        Map data = await res["data"];
        l.add(data["isPublic"].toString());
        l.add(data["isp"].toString());
        l.add(data["domain"].toString());
        l.add(data["countryCode"].toString());
        l.add("${data["abuseConfidenceScore"]}%");
        Map<String,String> headers2={
          'Accept': 'application/json',
          'x-apikey': apikey2,
        };
        String text=l[0];
        final Uri endpoint2=Uri.https("www.virustotal.com","/api/v3/ip_addresses/$text");
        Response response1=await get(endpoint2,headers: headers2);
        var resVt=jsonDecode(response1.body);
        Map dataVt=await resVt["data"]["attributes"]["last_analysis_stats"];
        int bl=dataVt["malicious"];
        int clean=dataVt["harmless"];
        int total=bl+clean;
        String scoreVt="${(bl/total)*100}%";
        l.add(scoreVt);
        Response response3=await get(Uri.parse("https://api.whatismyip.com/domain-black-list.php?key=$apikey3&input=$text&output=json"));
        var dataWIP=jsonDecode(response3.body);
        int tr=0;
        int fl=0;
        dataWIP["domain_blacklist"][0].forEach((key,value){
          if(value==false){
            tr+=1;
          }
          else if(value==true){
            fl+=1;
          }
        });
        int totalWIP=fl+tr;
        String scoreWIP="${(fl/totalWIP)*100}%";
        l.add(scoreWIP);
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
    return false;
  }

}
