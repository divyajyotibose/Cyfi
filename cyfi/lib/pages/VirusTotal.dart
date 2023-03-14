import 'dart:convert';

import 'package:cyfi/pages/loadpage.dart';
import 'package:cyfi/pages/navbar.dart';
import 'package:flutter/material.dart';
import 'package:cyfi/config/Palette.dart';
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
  List<String> rtype = [], rname = [], ttl = [], value = [];
  static String apikey2 =
      "3134e3908a8322f3ed85a13c0d8280df626917720d61df64955b49662292ac77";
  TextEditingController domain = TextEditingController();
  bool isloading = false;
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
      isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "VirusTotal",
          style: TextStyle(color: Palette.light),
        ),
        titleTextStyle: Palette.mainTitle,
        backgroundColor: Palette.accentColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: Palette.light),
      ),
      backgroundColor: Palette.accentColor,
      bottomNavigationBar: navbar(
        ind: _selectedIndex,
      ),
      body: isloading
          ? loadpage()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: domain,
                      decoration: InputDecoration(
                          fillColor: Palette.accentSubColor,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          hintText: "Search Domain",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isloading = true;
                              });
                              searchData();
                            },
                            icon: const Icon(Icons.search),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide())),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Center(
                      child: SingleChildScrollView(
                        child: Container(
                          height: height * 0.655,
                          width: width * 0.97,
                          decoration: BoxDecoration(
                            color: Palette.accentSubColor,
                            borderRadius: BorderRadius.circular(20),
                            // border: Border.all(width: 10,color: Color(0xfffca311)),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ListView.builder(
                                  itemCount: l.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index == 0) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        child: Row(
                                          children: const [
                                            Expanded(
                                                child: Text(
                                              "Record Type",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Expanded(
                                                child: Text("TTL",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            Expanded(
                                                child: Text("Value",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          ],
                                        ),
                                      );
                                    }
                                    return Column(
                                      children: [
                                        Card(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0),
                                            decoration: BoxDecoration(
                                                color: Palette.accentSubColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child:
                                                        Text(rtype[index - 1])),
                                                Expanded(
                                                    child:
                                                        Text(ttl[index - 1])),
                                                Expanded(
                                                    child:
                                                        Text(value[index - 1])),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        )
                                      ],
                                    );
                                  })),
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
