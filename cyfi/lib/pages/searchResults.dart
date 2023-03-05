import 'package:cyfi/config/palette.dart';
import 'package:cyfi/pages/apiCall.dart';
import 'package:flutter/material.dart';

class searchResults extends StatefulWidget {
  final bool ch1;
  final bool ch2;
  final bool ch3;
  final String text;
  const searchResults({super.key,required this.ch1,required this.ch2,required this.ch3,required this.text});
  @override
  State<searchResults> createState() => _searchResultsState();
}

class _searchResultsState extends State<searchResults> {
  bool? prop;String? text="";String? isp="";String? domain="";String? country="";String? usage="";
  String? network="",AutonomousSystemLabel="",RegionalInternetRegistry="",continent="",org="",state="",city="",pinCode="",AutonomousSystemNumber="";

    Future<void> setup() async {
    apiCall db=apiCall(ch1:widget.ch1,ch2:widget.ch2,ch3:widget.ch3,text:widget.text);
    await db.getData();
    setState(() {
      if(widget.ch1){
        prop=db.prop;
        text=db.text;
        isp=db.isp;
        domain=db.domain;
        country=db.country;
        usage=db.usage;
      }
      if(widget.ch2){
        network=db.network;
        AutonomousSystemLabel=db.AutonomousSystemLabel;
        RegionalInternetRegistry=db.RegionalInternetRegistry;
        continent=db.continent;
        org=db.org;
        country=db.country;
        state=db.state;
        city=db.city;
        pinCode=db.pinCode;
        AutonomousSystemNumber=db.AutonomousSystemNumber;
      }      
    });
  }

  @override
  void initState(){
    super.initState();
    setup();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width ;
    double height = MediaQuery. of(context). size. height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Results",style: TextStyle(color: palette.barTextColor),),
        centerTitle: true,
        backgroundColor: palette.bgColor,
        elevation: 0,
        iconTheme: IconThemeData(color: palette.barTextColor),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: height*0.8,
            width: width*0.8,
            decoration: BoxDecoration(
              color: palette.barColor,
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Visibility(
                  visible: widget.ch1,
                  child: Column(
                    children: [
                        Text("AbuseIPDB",style: TextStyle(fontSize: 15, decoration: TextDecoration.underline,),),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("IP Address"),
                            Text("$text"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ISP"),
                            Text("$isp"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Usage Type"),
                            Text("$usage")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Domain Name"),
                            Text("$domain")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Country"),
                            Text("$country")
                          ],
                        ),
                        SizedBox(height: 40,),
                ]),
                ),
                      Visibility(
                        visible: widget.ch2,
                        child: Column(
                          children: [
                            Text("VirusTotal",style: TextStyle(fontSize: 15, decoration: TextDecoration.underline,),),
                            SizedBox(height: 15,),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("IP Address"),
                                  Text("$text"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Network"),
                                  Text("$network"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Autonomous System Number"),
                                  Text("$AutonomousSystemNumber"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Autonomous System Label"),
                                  Text("$AutonomousSystemLabel"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Regional Internet Registry"),
                                  Text("$RegionalInternetRegistry"),
                                ],
                              ),
                              
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(""),
                              //     Text("$"),
                              //   ],
                              // ),
                          ],
                        ),
                      ),
                ]),
            ),
          ),
        ),
      ),
      backgroundColor: palette.bgColor,
    );
  }
}