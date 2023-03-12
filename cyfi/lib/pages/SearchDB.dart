import 'package:cyfi/pages/apiCall.dart';
import 'package:cyfi/pages/searchResults.dart';
import 'package:flutter/material.dart';
import 'package:cyfi/config/palette.dart';


class SearchDB extends StatefulWidget {
  const SearchDB({super.key});

  @override
  State<SearchDB> createState() => _SearchDBState();
}

class _SearchDBState extends State<SearchDB> {
  int _selectedIndex = 3;
  static TextEditingController ipAddress=TextEditingController();
  List<bool> isChecked=[true,true,true];
  String ip="";
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(index==0){
      Navigator.pushReplacementNamed(context, "/AbuseIPDB");
    }
    else if (index == 1) {
      Navigator.pushReplacementNamed(context, "/VirusTotal");
    }
    else if (index == 2) {
      Navigator.pushReplacementNamed(context, "/WIP");
    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width ;
    double height = MediaQuery. of(context). size. height;
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return palette.fillColor;
      }
      return palette.fillColor;
    }
    Column produce(ind,site,getColor,width){
      return Column(
        children: [
          Card(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(children: [
                Transform.scale(
                  scale: 1,
                  child: Checkbox(
                    checkColor: palette.checkColor,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked[ind],
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked[ind] = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10,),
                Text("$site",style: TextStyle(fontSize:width*0.043),
                )
              ],
              ),
            ),
          ),
          SizedBox(height: width/66,),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: palette.barColor,
          iconTheme: IconThemeData(color: palette.barTextColor),
        title: Text("Search",style: TextStyle(color: palette.barTextColor),),
        titleTextStyle: palette.mainTitle,
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: palette.barColor,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/index-removebg-preview.png",
              width: 30,
              height: 30,
            ),
            label: "AbDB",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/vt_icon-removebg-preview.png",
              width: 30,
              height: 30,
            ),
            label: "VT",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/wip-removebg-preview.png", width: 30, height: 30,),
            label: "WIP",
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.search,size: 30,), label: "Search"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      backgroundColor: palette.bgColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(height: 20,),
                TextField(
                  controller: ipAddress,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      hintText: "Search IP",
                      suffixIcon: IconButton(
                        onPressed: () {
                          ipAddress.text="";
                        },
                        icon: const Icon(Icons.clear),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide()
                      )
                  ),

                ),
                const SizedBox(height: 20,),
                Container(
                  height: height*0.6,
                  width: width*0.8,
                  decoration: BoxDecoration(
                      color: palette.ListColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text("Select Database",style: TextStyle(fontSize: height*0.03),),
                              SizedBox(height: height/33,),
                              produce(0, "AbuseIPDB", getColor, width),
                              produce(1, "VirusTotal", getColor, width),
                              produce(2, "WhatsMyIP", getColor, width),
                              Center(
                                child: TextButton(
                                  onPressed: (){
                                    ip=ipAddress.text;
                                    ipAddress.text="";
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context)=>searchResults(ch1:isChecked[0],ch2:isChecked[1],ch3:isChecked[2],text:ip))
                                    );
                                  },
                                  style: TextButton.styleFrom(backgroundColor: Colors.white),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text("Search",style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 0, 0, 0)),),
                                  ),

                                ),
                              ),
                            ]
                        ),
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

