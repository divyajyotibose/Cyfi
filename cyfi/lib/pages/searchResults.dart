import 'package:cyfi/config/Palette.dart';
import 'package:cyfi/pages/apiCall.dart';
import 'package:cyfi/pages/loadpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'message.dart';

class searchResults extends StatefulWidget {
  final bool ch1;
  final bool ch2;
  final bool ch3;
  final String text;
  const searchResults(
      {super.key,
      required this.ch1,
      required this.ch2,
      required this.ch3,
      required this.text});
  @override
  State<searchResults> createState() => _searchResultsState();
}

class _searchResultsState extends State<searchResults> {
  String? text = "";
  String? isp = "";
  String? domain = "";
  String? country = "";
  String? usage = "", score = "", prop = "";
  String? network = "",
      AutonomousSystemLabel = "",
      RegionalInternetRegistry = "",
      AutonomousSystemNumber = "";
  String? status = "",
      asn2 = "",
      country2 = "",
      region = "",
      city = "",
      pincode = "",
      isp2 = "",
      latitude = "",
      longitude = "",
      time = "";
  bool isloading = true;
  Future<void> setup() async {
    try {
      apiCall db = apiCall(
          ch1: widget.ch1, ch2: widget.ch2, ch3: widget.ch3, text: widget.text);
      await db.getData();
      setState(() {
        if (widget.ch1) {
          prop = db.prop;
          text = db.text;
          isp = db.isp;
          domain = db.domain;
          country = db.country;
          usage = db.usage;
          score = db.score;
        }
        if (widget.ch2) {
          network = db.network;
          AutonomousSystemLabel = db.AutonomousSystemLabel;
          RegionalInternetRegistry = db.RegionalInternetRegistry;
          country = db.country;
          city = db.city;
          AutonomousSystemNumber = db.AutonomousSystemNumber;
        }
        if (widget.ch3) {
          status = db.status;
          asn2 = db.asn2;
          country2 = db.country2;
          region = db.region;
          city = db.city;
          pincode = db.pincode;
          isp2 = db.isp2;
          time = db.time;
          longitude = db.longitude;
          latitude = db.latitude;
        }
      });
      setState(() {
        isloading = false;
      });
    }
    catch(e){
      mesage(context: context).box("Error", "WhatIsMyIP is not available");
    }
  }

  @override
  void initState() {
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Search Results",
        ),
        titleTextStyle: Palette.mainTitle,
        centerTitle: true,
        backgroundColor: Palette.accentColor,
      ),
      body: isloading
          ? loadpage()
          : Center(
              child: Container(
                height: height ,
                width: width * 0.98,
                decoration: BoxDecoration(
                    color: Palette.accentColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: widget.ch1,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Palette.accentSubColor),
                              child: Column(children: [
                                const Text(
                                  "AbuseIPDB",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                produce("IP Address", text),
                                produce("ISP", isp),
                                produce("Usage Type", usage),
                                produce("Domain Name", domain),
                                produce("Country", country),
                                produce("Abuse Confidence Score", score),
                              ]),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Visibility(
                            visible: widget.ch2,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Palette.accentSubColor,
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    "VirusTotal",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  produce("IP Address", text),
                                  produce("Network", network),
                                  produce("Autonomous System Number",
                                      AutonomousSystemNumber),
                                  produce("Autonomous System Label",
                                      AutonomousSystemLabel),
                                  produce("Regional Internet Registry",
                                      RegionalInternetRegistry),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Visibility(
                            visible: widget.ch3,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Palette.accentSubColor,
                              ),
                              child: (status!="ok")?const Text("WhatIsMyIP is not available"):Column(
                                children: [
                                  const Text(
                                    "WhatIsMyIP",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  produce("IP Address", text),
                                  produce("ISP", isp2),
                                  produce("Status", status),
                                  produce("Autonomous System Number", asn2),
                                  produce("Country", country2),
                                  produce("Region", region),
                                  produce("City", city),
                                  produce("Postal Code", pincode),
                                  produce("Time Zone", time),
                                  produce("Latitude", latitude),
                                  produce("Longitude", longitude),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
      backgroundColor: Palette.accentColor,
    );
  }

  Column produce(label, value) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: Text(
            "$label",
            textAlign: TextAlign.left,
          )),
          Flexible(
              child: Text(
            "$value",
            textAlign: TextAlign.right,
          )),
        ],
      ),
      Divider(
        color: Palette.mainColor,
      ),
    ]);
  }
}
