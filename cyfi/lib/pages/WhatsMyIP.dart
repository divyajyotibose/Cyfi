import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:cyfi/config//palette.dart';


class WhatsMyIP extends StatefulWidget {
  const WhatsMyIP({Key? key}) : super(key: key);

  @override
  State<WhatsMyIP> createState() => _WhatsMyIPState();
}

class _WhatsMyIPState extends State<WhatsMyIP> {
  bool isloading=false;
  TextEditingController proxy=TextEditingController();
  TextEditingController whois=TextEditingController();
  List keys=[],values=[];
  int _selectedIndex = 2;
  static String apikey3 = "f9d2272a01b3aa63a382f26e6cd71651";
  String? isproxy="",status="",proxy_type="",tor="",text="",lookup1="",lookup2="",whois_ip="";
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacementNamed(context, "/AbuseIPDB");
    }
    else if (index == 1) {
      Navigator.pushReplacementNamed(context, "/VirusTotal");
    }

    else if (index == 3) {
      Navigator.pushReplacementNamed(context, "/search");
    }
  }
  Future<void> getData() async {
    text=proxy.text;
    Response response=await get(Uri.parse("https://api.whatismyip.com/proxy.php?key=$apikey3&input=$text&output=json"));
    var data=jsonDecode(response.body);
    print(data);
    setState(() {
      status=data["proxy-check"][0]["status"].toString();
      isproxy=data["proxy-check"][1]["is_proxy"].toString();
      proxy_type=data["proxy-check"][1]["proxy_type"].toString();
      tor=data["proxy-check"][1]["tor_node"].toString();
    });

  }
  Future<void> getWhois() async {
    whois_ip=proxy.text;
    bool d;
    Response response=await get(Uri.parse("https://api.whatismyip.com/domain-black-list.php?key=$apikey3&input=$whois_ip&output=json"));
    var data=jsonDecode(response.body);
    print(data);
    setState(() {
      data["domain_blacklist"][0].forEach((key,value){
        keys.add(key);
        if(value==false){
          values.add("clean");
        }
        else if(value==true){
          values.add("Blacklisted");
        }
        else if(value=="ok"){
          values.add("ok");
        }
        });
    });
    setState(() {
      isloading=false;
    });
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WhatsMyIP", style: TextStyle(color: palette.barTextColor),),
        titleTextStyle: palette.mainTitle,
        backgroundColor: palette.barColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: palette.barTextColor),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: palette.barColor,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/index-removebg-preview.png", width: 30, height: 30,),
            label: "AbDB",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/vt_icon-removebg-preview.png", width: 30, height: 30,),
            label: "VT",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/wip-removebg-preview.png", width: 30, height: 30,),
            label: "WIP",
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.search,size: 30,),
              label: "Search"
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body:isloading?Center(
          child: Container(child: SpinKitSquareCircle(color: palette.barColor,),color: Color(0xff14213d),)
      )
          :Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: proxy,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    hintText: "Search Proxy",
                    suffixIcon: IconButton(
                      onPressed: () {
                        try {
                          setState(() {
                            isloading=true;
                          });
                          getData();
                          getWhois();
                        }
                        catch(e){
                          print(e);
                        }
                      },
                      icon: const Icon(Icons.search),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide()
                    )
                ),
              ),
              const SizedBox(height: 13,),
              Center(
                child: Container(
                  height: 0.72*height,
                  width: 0.97*width,
                  decoration: BoxDecoration(
                      color: palette.bgColor,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          (status != null)?Text(""):Column(
                        children: [
                          const Text("Proxy Check",textAlign: TextAlign.center,style:TextStyle(fontWeight: FontWeight.bold),),
                          produce("IP Address", text!),
                              produce("Status", status!),
                              produce("Proxy", isproxy!),
                              produce("Proxy Type", proxy_type!),
                              produce("Tor Node", tor!),
                        ],
                      ),
                          SizedBox(height: 13,),
                          Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:keys.length,
                                itemBuilder: (BuildContext context,int index){
                                  try{
                                    if(index==0){
                                      return const Text("Blacklist Check",textAlign: TextAlign.center,style:TextStyle(fontWeight: FontWeight.bold),);
                                    }
                                    return produce(keys[index],values[index]);
                                  }catch(e){
                                    print(e);
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Card produce(String label,String val){
    return Card(
      elevation:0,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color:const Color(0xFFF3E5D4),
            borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text("$label")),
            Expanded(child: Text("$val",textAlign: TextAlign.right,)),
          ],
        ),
      ),
    );
  }
  }

