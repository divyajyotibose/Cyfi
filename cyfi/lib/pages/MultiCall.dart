import "dart:convert";
import "package:csv/csv.dart";
import "package:http/http.dart";

class MultiCall{
  List<List<dynamic>>? file;
  MultiCall({required this.file});
  static String apikey1="b08b9dd59b34d8e52895bba9e0e0ad715172622d636d2da74645256449991bbbaa1bacbb81fa9a32";

  Future<dynamic> operation()async {
    int i=0;    
    file![0].add("Public");
    file![0].add("ISP");
    file![0].add("Domain"); 
    file![0].add("Country");
    file![0].add("Usage");
    Map<String,String> headers={
      'Accept': 'application/json',
      'Key': apikey1
    };
    for(var l in file!){
      if(i!=0)
      {
      Map<String,String> querystring = {
      'ipAddress': l[0],
      'maxAgeInDays': '90'
      };
      final Uri endpoint1=Uri.https("api.abuseipdb.com","/api/v2/check",querystring);
      Response response=await get(endpoint1,headers: headers);
      Map res=jsonDecode(response.body);   
      Map data=await res["data"];
      l.add( data["isPublic"]);
      l.add(data["isp"].toString());
      l.add(data["domain"].toString());
      l.add(data["countryCode"]);
      l.add(data["usageType"]); 
      }    
      else{
        i+=1;
      }
    }
    print(ListToCsvConverter().convert(file));
    return(ListToCsvConverter().convert(file));
  }

}