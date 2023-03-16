import 'package:cyfi/pages/apiCall.dart';
import 'package:cyfi/pages/navbar.dart';
import 'package:cyfi/pages/searchResults.dart';
import 'package:flutter/material.dart';
import 'package:cyfi/config/Palette.dart';

import 'message.dart';

class SearchDB extends StatefulWidget {
  const SearchDB({super.key});

  @override
  State<SearchDB> createState() => _SearchDBState();
}

class _SearchDBState extends State<SearchDB> {
  int _selectedIndex = 3;
  static TextEditingController ipAddress = TextEditingController();
  List<bool> isChecked = [true, true, true];
  String ip = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Palette.dark;
      }
      return Palette.dark;
    }

    Column produce(ind, site, getColor, width) {
      return Column(
        children: [
          Card(
            color: Palette.accentSubColor,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                children: [
                  Transform.scale(
                    scale: 1,
                    child: Checkbox(
                      checkColor: Palette.light,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isChecked[ind],
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked[ind] = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "$site",
                    style: TextStyle(
                        fontSize: width * 0.043, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: width / 66,
          ),
        ],
      );
    }
    Route _createRoute(is1,is2,is3,ip) {
      return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => searchResults(
              ch1: is1,
              ch2: is2,
              ch3: is3,
              text: ip),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300)
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.accentColor,
        title: Text(
          "Search",
          style: Palette.mainTitle,
        ),
        titleTextStyle: Palette.mainTitle,
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBar: navbar(ind: _selectedIndex),
      backgroundColor: Palette.accentColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: ipAddress,
                    decoration: InputDecoration(
                        fillColor: Palette.accentSubColor,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        hintText: "Search IP",
                        suffixIcon: IconButton(
                          onPressed: () {
                            ipAddress.text = "";
                          },
                          icon: const Icon(Icons.clear),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide())),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: height * 0.6,
                  width: width * 0.8,
                  decoration: BoxDecoration(
                      color: Palette.accentSubColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(40))),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "Select Database",
                                style: TextStyle(
                                    fontSize: height * 0.03,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: height / 33,
                              ),
                              produce(0, "AbuseIPDB", getColor, width),
                              produce(1, "VirusTotal", getColor, width),
                              produce(2, "WhatIsMyIP", getColor, width),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    if(ipAddress.text==""){
                                      mesage(context: context).box("Error", "Please enter a valid IP Address");
                                    }else {
                                      ip = ipAddress.text;
                                      ipAddress.text = "";
                                      Navigator.of(context).push(_createRoute(
                                          isChecked[0], isChecked[1],
                                          isChecked[2], ip));
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Palette.mainColor,
                                  ),
                                  child: Padding(
                                    padding: Palette.mainPadding,
                                    child: Text("Search",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Palette.accentSubColor)),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
