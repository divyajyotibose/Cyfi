import 'dart:convert';


import "package:http/http.dart";


class apiCall{
  bool ch1;
  bool ch2;
  bool ch3;
  String text;
  bool? prop;String? isp="";String? domain="",country="", usage="";
  String? network="",AutonomousSystemLabel="",RegionalInternetRegistry="",continent="",org="",state="",city="",pinCode="",AutonomousSystemNumber="";
  apiCall({required this.ch1,required this.ch2,required this.ch3,required this.text});
  static String apikey1="b08b9dd59b34d8e52895bba9e0e0ad715172622d636d2da74645256449991bbbaa1bacbb81fa9a32";
  static String apikey2="3134e3908a8322f3ed85a13c0d8280df626917720d61df64955b49662292ac77";
  
  Future<void> getData() async {
    if(ch1){ 
      Map<String,String> headers1={
      'Accept': 'application/json',
      'Key': apikey1
    };
    Map<String,String> querystring1 = {
      'ipAddress': text,
      'maxAgeInDays': '90'
    };
    final Uri endpoint1=Uri.https("api.abuseipdb.com","/api/v2/check",querystring1);
    Response response=await get(endpoint1,headers: headers1);
    Map res=jsonDecode(response.body);   
    Map data=await res["data"];
    prop= data["isPublic"];
    isp=data["isp"].toString();
    domain=data["domain"].toString();
    country=data["countryCode"];
    usage=data["usageType"];
  }
    if(ch2){
      Map<String,String> headers2={
      'Accept': 'application/json',
      'x-apikey': apikey2,
      };
      Map<String,String> querystring2 = {
      'ip': text,
      };
    //developers.virustotal.com/reference/scan-url
    final Uri endpoint2=Uri.https("www.virustotal.com","/api/v3/ip_addresses/$text");
    Response response=await get(endpoint2,headers: headers2);

    var res=jsonDecode(response.body);
    Map data=await res["data"]["attributes"];
    org=data["OrgName"];
    network=data["network"].toString();
    country=data["country"];
    continent=data["continent"];
    AutonomousSystemLabel=data["as_owner"];
    RegionalInternetRegistry=data["regional_internet_registry"].toString();
    state=data["StateProv"].toString();
    city=data["City"].toString();
    pinCode=data["PostalCode"].toString();
    AutonomousSystemNumber=data["asn"].toString();
    print(data);
    }
    if(ch3){

    }
  }
  


}
