import 'dart:convert';
import "package:http/http.dart";


class apiCall{
  bool ch1;
  bool ch2;
  bool ch3;
  String text;
  String? isp="";String? domain="",country="", usage="",score="",prop="";
  String? network="",AutonomousSystemLabel="",RegionalInternetRegistry="",AutonomousSystemNumber="";
  String? status="",asn2="",country2="",region="",city="",pincode="",isp2="",latitude="",longitude="",time="";
  apiCall({required this.ch1,required this.ch2,required this.ch3,required this.text});
  static String apikey1="b08b9dd59b34d8e52895bba9e0e0ad715172622d636d2da74645256449991bbbaa1bacbb81fa9a32";
  static String apikey2="3134e3908a8322f3ed85a13c0d8280df626917720d61df64955b49662292ac77";
  static String apikey3="f9d2272a01b3aa63a382f26e6cd71651";

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
      prop= data["isPublic"].toString();
      isp=data["isp"].toString();
      domain=data["domain"].toString();
      country=data["countryCode"];
      usage=data["usageType"];
      score=data["abuseConfidenceScore"].toString();
    }
    if(ch2){
      Map<String,String> headers2={
        'Accept': 'application/json',
        'x-apikey': apikey2,
      };
      final Uri endpoint2=Uri.https("www.virustotal.com","/api/v3/ip_addresses/$text");
      Response response=await get(endpoint2,headers: headers2);
      var res=jsonDecode(response.body);
      Map data=await res["data"]["attributes"];
      print(data);
      network=data["network"].toString();
      country=data["country"];
      AutonomousSystemLabel=data["as_owner"];
      RegionalInternetRegistry=data["regional_internet_registry"].toString();
      city=data["City"].toString();
      AutonomousSystemNumber=data["asn"].toString();
    }
    if(ch3){
      Response response=await get(Uri.parse("https://api.whatismyip.com/ip-address-lookup.php?key=$apikey3&input=$text&output=json"));
      print(response.body);
      Map data=jsonDecode(response.body);
      status=data["ip_address_lookup"][0]["status"].toString();
      asn2=data["ip_address_lookup"][0]["asn"].toString();
      country2=data["ip_address_lookup"][0]["country"].toString();
      region=data["ip_address_lookup"][0]["region"].toString();
      city=data["ip_address_lookup"][0]["city"].toString();
      pincode=data["ip_address_lookup"][0]["postalcode"].toString();
      isp2=data["ip_address_lookup"][0]["isp"].toString();
      time=data["ip_address_lookup"][0]["time"].toString();
      latitude=data["ip_address_lookup"][0]["latitude"].toString();
      longitude=data["ip_address_lookup"][0]["longitude"].toString();
    }
  }



}
