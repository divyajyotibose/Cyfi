
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cyfi/config/palette.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "package:http/http.dart";


class VirusTotal extends StatefulWidget {
  const VirusTotal({super.key});

  @override
  State<VirusTotal> createState() => _VirusTotalState();
}

class _VirusTotalState extends State<VirusTotal> {
  List l = [];
  int _selectedIndex = 1;
  List<String> rtype = [],
      rname = [],
      ttl = [],
      value = [];
  static String apikey2 = "3134e3908a8322f3ed85a13c0d8280df626917720d61df64955b49662292ac77";
  TextEditingController domain = TextEditingController();
  bool isloading=false;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacementNamed(context, "/AbuseIPDB");
    }
    else if (index == 2) {
      Navigator.pushReplacementNamed(context, "/WIP");
    }
    else if (index == 3) {
      Navigator.pushReplacementNamed(context, "/search");
    }
  }

  Future<void> searchData() async {
    String d = domain.text;
    Map<String, String> headers2 = {
      'Accept': 'application/json',
      'x-apikey': apikey2,
    };

    final Uri endpoint2 = Uri.https("www.virustotal.com", "/api/v3/domains/$d");
    Response response = await get(endpoint2, headers: headers2);

    var res = jsonDecode(response.body);
    Map data = await res["data"]["attributes"];
    setState(() {
      rtype = [];
      value = [];
      ttl = [];
      for (int i = 0; i <= 5; i++) {
        rtype.add(data["last_dns_records"][i]["type"].toString());
        value.add(data["last_dns_records"][i]["value"]);
        ttl.add(data["last_dns_records"][i]["ttl"].toString());

      }
      l = List.generate(7, (index) => "Sample Item $index");
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
          "VirusTotal", style: TextStyle(color: palette.barTextColor),),
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
      body: isloading?Center(
          child: Container(child: SpinKitSquareCircle(color: palette.barColor,),color: Color(0xff14213d),)
      )
          :SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: domain,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    hintText: "Search Domain",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isloading=true;
                        });
                        searchData();

                      },
                      icon: const Icon(Icons.search),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide()
                    )
                ),

              ),
              const SizedBox(height: 20,),

              Center(
                child: SingleChildScrollView(
                  child: Container(
                    height: height * 0.7,
                    width: width * 0.97,
                    decoration: BoxDecoration(
                        color: palette.bgColor,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.builder(
                          itemCount: l.length,
                          itemBuilder: (BuildContext context,int index){
                            if(index==0){
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                child: Row(
                                  children: [
                                    const Expanded(child: Text("Record Type",style: TextStyle(fontWeight: FontWeight.bold),)),
                                    const Expanded(child: Text("TTL",style: TextStyle(fontWeight: FontWeight.bold))),
                                    const Expanded(child: Text("Value",style: TextStyle(fontWeight: FontWeight.bold))),
                                  ],
                                ),
                              );
                            }
                            return Column(
                              children: [
                                Card(
                                  elevation:0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                    child: Row(
                                      children: [
                                        Expanded(child: Text(rtype[index-1])),
                                        Expanded(child: Text(ttl[index-1])),
                                        Expanded(child: Text(value[index-1])),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      color:const Color(0xFFF3E5D4),
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4,)
                              ],
                            );
                          })
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

}